# [15:10:33] Pavel Krautsou: Дано: N наблюдений. Есть 2 фичи. Есть 2 класса, они не сбаласированны
# [15:10:58] Pavel Krautsou: фичи имею слабу предсказательную способность, но все же имеют
# [15:12:13] Pavel Krautsou: Задача: показать, измененнение ожидания пренадлежности к классу в зависимости от значений объясняющих переменных

set.seed(123)
Var1 = rnorm(10000)
Var2 = rnorm(10000)

response = sample(0:1, 10000, replace = TRUE, prob = c( 0.875,0.125) )


df = data.frame( Var1, Var2, y = response)
df$Var1[df$y == 1] = df$Var1[df$y == 1] + 0.4
df$Var2[df$y == 1] = df$Var2[df$y == 1] + 0.2

df$y = factor(df$y, levels = c(0,1), labels = c("No", "Yes"))

require(ggplot2)
require(rpart)
ggplot(df, aes(x=Var1)) + geom_density(aes(group=y, colour=y))
ggplot(df, aes(x=Var2)) + geom_density(aes(group=y, colour=y))

t.test(df$Var2 ~ df$y)
t.test(df$Var1 ~ df$y)

fit3 = rpart(y~., data = df, parms=list(prior=c(.5,.5)))
fit3
require(rattle)
fancyRpartPlot(fit3)

fit4 = lda(y~., data = df, prior = c(0.5, 0.5))
plot(fit4)

pred = predict(fit4)
pred = pred$posterior[,2]

fit4 = lda(y~., data = df, prior = c(0.5, 0.5))


qplot( Var1, Var2, data = df, size = pred, alpha = I(1/20))
qplot( Var1, Var2, data = df, size = 1000, alpha = I(1/20), col = y)

moreLikeli = factor(pred > 0.5)
qplot( Var1, Var2, data = df, size = pred, alpha = I(1/20), col = moreLikeli)
