
# Source code by https://github.com/topepo/caret/issues/492

require(caret)
require(xgboost)
require(stats)
require(ggplot2)
require(data.table)
require(plyr)
require(dplyr)
require(tidyr)

# URL of the training and testing data
train.url ="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
test.url = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

# file names
train.name = "./data/pml-training.csv"
test.name = "./data/pml-testing.csv"

# if directory does not exist, create new
if (!file.exists("./data")) {
  dir.create("./data")
}

# if files does not exist, download the files
if (!file.exists(train.name)) {
  download.file(train.url, destfile=train.name, method="libcurl")
}
if (!file.exists(test.name)) {
  download.file(test.url, destfile=test.name, method="libcurl")
}

# load the CSV files as data.frame
train = fread("./data/pml-training.csv")
test = fread("./data/pml-testing.csv")

# clean the data
classe <- train[, "classe",with=F][[1]] %>% as.factor()
y = classe %>% {as.numeric(.)-1}

train = train[,V1:=NULL]
test = test[,V1:=NULL]
train = train[,classe:=NULL]

# The assignment rubric asks to use data from accelerometers on the belt, forearm, arm, and dumbell.
# filter columns on: belt, forearm, arm, dumbell
filter = grepl("belt|arm|dumbell", names(train))
train = train[, filter, with=F]
test = test[, filter, with=F]
nanames <- which(colMeans(is.na(train)) > 0.6) %>% names
train = train[, c(nanames):=NULL]
test = test[,c(nanames):=NULL]
zero.var = nearZeroVar(train, saveMetrics=TRUE)
zero.var
zeronames <- zero.var[which(zero.var$nzv),] %>% row.names
train = train[, c(zeronames):=NULL]
test = test[,c(zeronames):=NULL]

# convert data to matrix
train.matrix = as.matrix(train)
mode(train.matrix) = "numeric"
test.matrix = as.matrix(test)
mode(test.matrix) = "numeric"
num.class <- max(y) + 1

# tuning the parameters
xgbGrid <- expand.grid(
  nrounds = 20,
  max_depth = c(6=),
  eta = c(0.01),
  gamma = 1,
  colsample_bytree = 0.5,
  min_child_weight = 6,
  subsample = 0.8
)

xgbTrControl <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 2,
  returnData = FALSE,
  classProbs = TRUE,
  summaryFunction = multiClassSummary
)

set.seed(1234)

xgbTrain <- train(
  x = train.matrix,
  y = classe,
  trControl = xgbTrControl,
  tuneGrid = xgbGrid,
  method = "xgbTree",
  metric = "Accuracy",
  
  objective = "multi:softprob",
  num_class = num.class
)
# I get the following error message:
  # Warning messages:
  # 1: In check.booster.params(params, ...) :
  # The following parameters were provided multiple times:
  # num_class, objective



# XGBoost results
#prediction of class on test set
xgbpred <- predict(xgbTrain, test.matrix)

test_for_test <- fread("./data/pml-testing.csv")

confusion_matrix <- confusionMatrix(xgbpred,  factor(test_for_test$problem_id))

#how many hdds are truthly predicted as failures
pred_probs <- header_test[,pred_prob := predict(xgbTrain, test.matrix, type="prob")[2]]
print(paste0("$pred_probs includes predicted probabilities of class ", colnames(predict(xgbTrain, test.matrix, type="prob"))[2]))

importance_df <- data.frame(column_name = rownames(varImp(xgbTrain)$importance), varImp(xgbTrain)$importance)

library(pROC)
xgbROC <- roc(response = as.vector(Y_test), predictor = pred_probs$pred_prob)
auc(xgbROC)

return(list(fit = xgbTrain,
            prediction = xgbpred,
            prediction_probs = pred_probs,
            confusion_matrix = confusion_matrix,
            importance_df = importance_df,
            ROC = xgbROC,
            train_cols = colnames(X_train),
            target_cols = target))