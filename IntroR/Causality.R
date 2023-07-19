
write.csv(resume, "resume.csv")
resume<-read.csv("resume.csv")

### Basic descriptive stats of the data ###

# number of columns and rows
dim(resume)
# [1] 4870    4

head(resume)
#  firstname    sex  race call
#1   Allison female white    0
#2   Kristen female white    0
#3   Lakisha female black    0
#4   Latonya female black    0
#5    Carrie female white    0
#6       Jay   male white    0

summary(resume)
#   firstname             sex                race                call        
#Length:4870        Length:4870        Length:4870        Min.   :0.00000  
#Class :character   Class :character   Class :character   1st Qu.:0.00000  
#Mode  :character   Mode  :character   Mode  :character   Median :0.00000  
#                                                         Mean   :0.08049  
#                                                         3rd Qu.:0.00000  
#                                                         Max.   :1.00000 

race.call.tab <-table(race = resume$race, call = resume$call)
race.call.tab
#.        call
# race       0    1
# black   2278  157
# white.  2200  235

addmargins(race.call.tab)
#         call
# race    0    1  Sum
# black 2278  157 2435
# white 2200  235 2435
# Sum   4478  392 4870

## overall callback rate: total callbacks divieded by the sample size 

sum(race.call.tab[, 2])/nrow(resume)
# [1] 0.08049281

## callback rates for each race 
race.call.tab[1,2]/sum(race.call.tab[1, ]) # black
# [1] 0.06447639

race.call.tab[2,2] /sum(race.call.tab[2,]) # white
# [1] 0.09650924


race.call.tab[1, ]  # the first row
#    0    1 
# 2278  157

race.call.tab[, 2]  # the second row
# black white 
# 157   235 

mean(resume$call)
# [1] 0.08049281

#### subsetting the data ####

class(TRUE)
# [1] "logical"

## converting logical values to binary values
as.integer(TRUE)
# [1] 1

as.integer(FALSE)
# [1] 0

x <- c(TRUE, FALSE, TRUE) # a vector with logical values 

mean(x) # proportion of TRUEs
# [1] 0.6666667
sum(x) # number of TRUEs
# [1] 2

## logical conjunctions ##

# & = AND
FALSE & TRUE
# [1] FALSE

TRUE & TRUE
# [1] FALSE

# | = OR

TRUE | FALSE
# [1] TRUE

FALSE | FALSE
# [1] FALSE

(TRUE | FALSE) & FALSE # the parentheses evaluate to TRUE
# [1] FALSE
TRUE | (FALSE & FALSE) # the parentheses evaluate to FALSE
# [1] TRUE

TF1 <- c(TRUE, FALSE, FALSE)
TF2 <- c(TRUE, FALSE, TRUE)

TF1 | TF2
# TRUE FALSE  TRUE

TF1 & TF2
# [1]  TRUE FALSE FALSE

## relational operators

# is 4 greater than 3?
4 > 3
# [1] TRUE

# is Hello equal to hello?
"Hello" == 'hello' # r is case sensitive
# [1] FALSE

# is Hello NOT equal to hello? 
"Hello" != 'hello'
# [1] TRUE

x<- c(3, 2, 1, -2, -1)
# is the vector x greater than or equal to 2
x >= 2
# [1]  TRUE  TRUE FALSE FALSE FALSE

x != 1
# [1]  TRUE  TRUE FALSE  TRUE  TRUE

## logical conjunction of two vectors with logical values
(x > 0) & (x <= 2)
# [1]  FALSE  TRUE  TRUE FALSE FALSE

(x > 2) & (x <= -1)
# [1] FALSE FALSE FALSE FALSE FALSE

x.int <- (x>0) & (x<=2) # logical vector
x.int 
# [1] FALSE  TRUE  TRUE FALSE FALSE

mean(x.int) # proportion of TRUEs
# [1] 0.4

sum(x.int) # number of TRUEs
# [1] 2

## SUBSETING 

## callback rate for black-sounding names
mean(resume$call[resume$race == "black"])
# [1] 0.06447639

## rave of first 5 observations
resume$race[1:5]
# [1] "white" "white" "black" "black" "white"

# comparision of first 5 observations
(resume$race == "black")[1:5]
# [1] FALSE FALSE  TRUE  TRUE FALSE

dim(resume) # dimension of orginal date frame
# [1] 4870    4

# subset blacks only
resumeB <- resume[resume$race == "black", ]
dim(resumeB)
# [1] 2435    4

mean(resumeB$call) #call back rate for blacks
# [1] 0.06447639

library(dplyr)
## keep 'call' and "firstname" variables
# also keep observations with female black-sounding names
resumeBf <- subset(resume, select = c("call", "firstname"),
                   subset = (race == "black" & sex == "female"))
head(resumeBf)
#    call firstname
# 3     0   Lakisha
# 4     0   Latonya
# 8     0     Kenya
# 9     0   Latonya
# 11    0     Aisha
# 13    0     Aisha  

# alternative syntax with the same result
resumeBf <- resume[resume$race == "black" & resume$sex == "female", 
                   c("call", "firstname")]


## black male
resumeBm <- subset(resume, subset = (race == "black") & (sex == "male"))

## white female  
resumeWf <- subset(resume, subset = (race == "white") & (sex == "female"))

## white male
resumeWm <- subset(resume, subset = (race == "white") & (sex == "male"))

## racial gaps
mean(resumeWf$call) - mean(resumeBf$call) # amoung females
# [1] 0.03264689
mean(resumeWm$call) - mean(resumeBm$call) # amoung males
# [1] 0.03040786


resume$BlackFemale <- ifelse(resume$race == "black" & 
                               resume$sex == "female", 1,0)

table(race = resume$race, sex = resume$sex,
      BlackFemale = resume$BlackFemale)

## , , BlackFemale = 0

# sex
# race    female male
# black      0  549
# white   1860  575

# , , BlackFemale = 1

# sex
# race    female male
# black   1886    0
# white      0    0

## factor variables

resume$type <- NA
resume$type[resume$race == "black" & resume$sex == "female"] <- "BlackFemale"
resume$type[resume$race == "black" & resume$sex == "male"] <- "BlackMale"
resume$type[resume$race == "white" & resume$sex == "female"] <- "WhiteFemale"
resume$type[resume$race == "white" & resume$sex == "male"] <- "WhiteMale"

class(resume$type)
# [1] "character"

## coerce new character variable into a factor variable
resume$type <- as.factor(resume$type)
## list all levels of a factpr variable
levels(resume$type)
# [1] "BlackFemale" "BlackMale"   "WhiteFemale" "WhiteMale" 

## obtain the number of observations for each level
table(resume$type)
# BlackFemale   BlackMale WhiteFemale   WhiteMale 
# 1886         549        1860         575

tapply(resume$call, resume$type, mean)
# BlackFemale   BlackMale WhiteFemale   WhiteMale 
# 0.06627784  0.05828780  0.09892473  0.08869565 

##turne first name into a factor variable
resume$firstname <- as.factor(resume$firstname)
## compute callback rate for each first name
callback.name <-tapply(resume$call, resume$firstname, mean)
## sort the result into increasing order 
sort (callback.name)
#      Aisha    Rasheed     Keisha   Tremayne     Kareem    Darnell     Tyrone      Hakim     Tamika    Lakisha 
# 0.02222222 0.02985075 0.03825137 0.04347826 0.04687500 0.04761905 0.05333333 0.05454545 0.05468750 0.05500000 
# Tanisha       Todd      Jamal       Neil      Brett   Geoffrey    Brendan       Greg      Emily       Anne 
# 0.05797101 0.05882353 0.06557377 0.06578947 0.06779661 0.06779661 0.07692308 0.07843137 0.07929515 0.08264463 
# Jill     Latoya      Kenya    Matthew    Latonya      Leroy    Allison      Ebony   Jermaine     Laurie 
# 0.08374384 0.08407080 0.08673469 0.08955224 0.09130435 0.09375000 0.09482759 0.09615385 0.09615385 0.09743590 
# Sarah   Meredith     Carrie    Kristen        Jay       Brad 
# 0.09844560 0.10160428 0.13095238 0.13145540 0.13432836 0.15873016 