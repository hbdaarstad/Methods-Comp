##### Introduction to R ########


#### Using R as a Calculator ######

## Arthmitic calculations

#Addition
5 + 3
# [1] 8

#Subtraction
5 - 3
# [1] 2

#Division
5 / 3 
# [1] 1.666667

#Exponents
5^3
# [1] 125

#square root
sqrt(4)
# [1] 2

#order of operations
5 * (10 - 3)
# [1] 35

###### OBJECTS ######

#numerical objects 
result <- 5 + 3
print(result)
# [1] 8

result <- 5 - 3
result
# [1] 2
class(result)
# [1] "numeric"

#string objects
result <- "instructor"
result
# [1] "instructor"
class(result)
# [1] "character"
###### VECTORS ######

world.pop <- c(2525779, 3026003, 3691173, 4449049, 5320817, 6916183)
world.pop
# [1] 2525779 3026003 3691173 4449049 5320817 6916183

pop.first <- c(2525779, 3026003, 3691173)
pop.second <- c(4449049, 5320817, 6916183)
pop.all <- c(pop.first, pop.second)
pop.all
# [1] 2525779 3026003 3691173 4449049 5320817 6916183

#extracting certain pieces of teh vector

world.pop[2]
# [1] 3026003

world.pop[c(2,4)]
# [1] 3026003 4449049

world.pop[1:3]
#[1] 2525779 3026003 3691173

world.pop[c(1:3,6)]
# [1] 2525779 3026003 3691173 6916183

#removing an element
world.pop[-3]
# [1] 2525779 3026003 4449049 5320817 6916183

pop.million <- world.pop/1000
pop.million
# [1] 2525.779 3026.003 3691.173 4449.049 5320.817 6916.183

pop.rate <- world.pop / world.pop[1]
pop.rate
# [1] 1.000000 1.198047 1.461400 1.761456 2.106604 2.738238




###### FUNCTIONS ######

length(world.pop)
# [1] 6

min(world.pop)
# [1] 2525779

max(world.pop)
# [1] 6916183

range(world.pop)
# [1] 2525779 6916183

mean(world.pop)
# [1] 4321501

sum(world.pop)/length(world.pop)
# [1] 4321501

median(world.pop)
# [1] 4070111

summary(world.pop) 
#  Min.   1st Qu. Median    Mean   3rd Qu.  Max. 
# 2525779 3192296 4070111 4321501 5102875 6916183


year <- seq(from = 1950, to = 2010, by = 10)
year
# [1] 1950 1960 1970 1980 1990 2000 2010

2008:2012
# [1] 2008 2009 2010 2011 2012
2012:2008
# [1] 2012 2011 2010 2009 2008

## fix to match world.pop to match vector
world.pop <- c(2525779, 3026003, 3691173, 4449049, 5320817, 6127700, 6916183)
world.pop

names(world.pop)
# NULL

names(world.pop) <- year
names(world.pop)
# [1] "1950" "1960" "1970" "1980" "1990" "2000" "2010"

world.pop
#    1950    1960    1970    1980    1990    2000    2010 
# 2525779 3026003 3691173 4449049 5320817 6127700 6916183

# myfunction <- function(input1, input2, .... inputN) {
#  DEFINE "output" USING INPUTS
# return(output)
# }

my.summary <- function(x) {
  s.out <- sum(x)
  l.out <- length(x)
  m.out <- s.out / l.out
  out <- c(s.out, l.out, m.out) # define the output
  names (out) <- c("sum", "length", "mean")
  return(out)
}

z <- 1:10
my.summary(z)
#  sum length   mean 
# 55.0   10.0    5.5 

my.summary(world.pop)
#      sum   length     mean 
# 32056704        7  4579529



###### DATE FRAME ######

#creating csv
write.csv(world.pop, "UNpop.csv")
UNpop <- read.csv("UNpop.csv")

#changing column names
library(dplyr)
colnames(UNpop)[1] ="year"
colnames(UNpop)[2] ="population"

#column names
names(UNpop)
# [1] "year"       "population"

#number of rows
nrow(UNpop)
# [1] 7

#number of columns
ncol(UNpop)
# [1] 2

# numbers of rows and columns
dim(UNpop)
# [1] 7 2

summary(UNpop)
#  year        population     
# Min.   :1950   Min.   :2525779  
# 1st Qu.:1965   1st Qu.:3358588  
# Median :1980   Median :4449049  
# Mean   :1980   Mean   :4579529  
# 3rd Qu.:1995   3rd Qu.:5724258  
# Max.   :2010   Max.   :6916183 

UNpop$population
# [1] 2525779 3026003 3691173 4449049 5320817 6127700 6916183

UNpop[, "population"]
# [1] 2525779 3026003 3691173 4449049 5320817 6127700 6916183

UNpop[1:3, "year"]
# [1] 1950 1960 1970

#take elements 1, 3, 5, .... N of the "population" varaible
UNpop$population[seq(from = 1, to =nrow(UNpop), by = 2)]
# [1] 2525779 3691173 5320817 6916183

# removing NAs
world.pop <- c(world.pop, NA)
world.pop
#    1950    1960    1970    1980    1990    2000    2010         
# 2525779 3026003 3691173 4449049 5320817 6127700 6916183      NA 

mean(world.pop)
# [1] NA

mean(world.pop, na.rm = TRUE)
# [1] 4579529