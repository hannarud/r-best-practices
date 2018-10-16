
# Knapsack problem solution

data <- read.csv2("knapsack.csv", encoding = "UTF-8", stringsAsFactors = FALSE)


# Input:
# Values of things to put into bag
v <- data$Level
# Weights of things to put into bag
w <- data$Min_ZP
# Amount of things available (n)
n = nrow(data)
# Maximum weight allowed (W)
W = 7000

# All the sums can be divided into 100 as they are divisible by 100
w = w/100
W = W/100

m = matrix(nrow = n+1, ncol = length(0:W))

rownames(m) <- c("Никто", data$Name)
colnames(m) <- as.character(0:W)

for(j in 0:W+1) {
  m[1, j] = 0
}

for(i in 2:(n+1)) {
  for(j in 0:W+1){
    print(w[i-1])
    print(j)
    if(w[i-1] > j){
      m[i, j] = m[i-1, j]
    }
    else {
      m[i, j] = max(m[i-1, j], m[i-1, j-w[i-1]] + v[i-1])
    }
  }
  print(i)
}

findAns <- function(k, s) {
  if(m[k, s] == 0) {
    return(0)
  }
  if(m[k - 1, s] == m[k, s]) {
    findAns(k-1, s)
  }
  else {
    findAns(k-1, s-w[k-1])
    print(rownames(m)[k])
  }
}

findAns(n+1, length(0:W))
