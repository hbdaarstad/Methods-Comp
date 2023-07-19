 ## Loops in R

# for ( i in X ) {
# expression1
# expression2
# ...expressionN
# }

values <- c(2, 4, 6)

n<-length(values) # number of elements in "values"
results <- rep(NA, n) # exmpty container vector for storing the results 
## loop ounter "i" will take values 1, 2, ...., n in that order
for ( i in 1:n) {
  ## store the result of multipliction as the ith element of 
  ## "results" vector
  results[i] <- values[i] * 2
  cat(values[i], "times 2 is equal to", results[i], "\n")
}

## 2 times 2 is equal to 4
## 4 times 2 is equal to 8
## 6 times 2 is equal to 12

results
# [1]  4  8 12

i <- 1

x <- vlues[i] * 2
cat(values[i], "times 2 is equal to", x, "\n")

## 2 times is equal to 4

## a toy data frame
data <- data.frame("a" = 1:2, "b" = c("hi", "hey"), "c" = 3:4)
## we see an error occuring a iteration 2
results <- rep(NA, 3)
for (i in 1:3) {
  cat("iteration", 1, "\n")
  results[i] <- median(data[, 1])
}
## iteration 1
## iteration 2

## error in median.default(data[. i]): need numeric data

results 
# [1] 1 NA NA


# for ( i in X ) {
# expression1
# expression2
# ...expressionN
# }


## define the opertion to be expected 
operation <- "add"

if (operation == "add") {
  cat(" I will preform addition 4 + 4\n")
  4 + 4
}
## I will preform addition 4 + 4
## [1] 8

if (operation == "multiply") {
  cat("I will preform addition 4 * 4\n")
  4 * 4
}

if (x) {
  expression1a
  ...
  expressionNa
} else {
  expression1b
  ...
  expressionNb
}

## note that "operation" is redfined 
operation <- "mulitply" 
if (operation == "add") {
  cat(" I will preform addition 4 + 4\n")
  4 + 4
} else {
  cat("I will preform addition 4 * 4\n")
  4 * 4
}

if (x) {
  expression1a
  ...
  expressionNa
  
} else if (Y) {
  expression1b
  ...
  expressionNb
  
} else {
  expression1c
  ...
  expressionNc
}

## note that "operation" is redefined

operation <- "subtract"

if (operation == "add") {
  cat(" I will preform addition 4 + 4\n")
  4 + 4
} else if (operation == "multiply") {
  cat("I will preform addition 4 * 4\n")
  4 * 4
} else {
  cat(" "" , operation, ""  is invalid. Use either "add" or "multiply". \n ",
        sep = "")
}

## "subtract is invalid. Use either "add" or "multiply"

values <- 1:5
n <- length(values)
results <- rep(NA, n)
for (i in 1:n) {
  ## x and r get overwritten in each iteration 
  x <- values[i]
  r <- x %% 2 # remainder when divded by 2 to check whether even or odd
  if (r == 0) { # remainder is zero
    cat (x, "is even and I will preform addition",
         x, "+", x, "\n")
    results[i] <- x*x
  } else { # remainder is not zero
    cat(x, "is odd and I will preform multiplicator",
        x, "*", x, "\n")
    results[i] <- x * x
  }
} 
# 1 is odd and I will preform multiplicator 1 * 1 
# 2 is even and I will preform addition 2 + 2 
# 3 is odd and I will preform multiplicator 3 * 3 
# 4 is even and I will preform addition 4 + 4 
# 5 is odd and I will preform multiplicator 5 * 5 

results
# [1]  1  4  9 16 25