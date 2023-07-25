

## Example: Elections and the Economy

hibbs <- read.csv("hibbs.csv")
plot(hibbs$growth, hibbs$vote, xlab="Average recent growth in personal income", ylab="Incumbent party's vote share")

## adding a fitted line
library(rstanarm)
m1 <- stan_glm(vote ~ growth, data=hibbs, refresh=0)
plot(hibbs$growth, hibbs$vote, xlab="Average recent growth in personal income", ylab="Incumbent party's vote share")
abline(coef(m1), col="gray")
print(m1)

#### Bayseian Regression

# discrete predictor variable
x<-rbinom(100, 1, 0.5)

# continuous outcome variable
y<-rnorm(100, 3, 1)

mydata <- data.frame(x,y)

fit <- stan_glm(y~x, data=mydata, refresh=0)
summary(fit)


#### Ordinary least squares

# continuous predictor variable
x<-rnorm(100, 1, 1)

# continuous outcome variable
y<-rnorm(100, 3, 1)

mydata <- data.frame(x,y)

fit <- lm(y~x, data=mydata, refresh=0)
summary(fit)