

##### Social Pressure Experiment Data Example #####
## Examining possible lack of differences across groups in a RCTs that can disrupt external validity

social <- read.csv("social.csv") # load the data
social <- social[, -1]
summary(social) # summarize the data

## turnout for each group 
tapply(social$primary2006, social$messages, mean)

## turnout for control group 
mean(social$primary2006[social$messages=="Control"])

## subtract control group turnout from each group
tapply(social$primary2006, social$messages, mean) - mean(social$primary2006[social$messages=="Control"])

social$age <- 2006 - social$yearofbirth # create age variable
tapply(social$age, social$messages, mean)

tapply(social$primary2004, social$messages, mean)

tapply(social$hhsize, social$messages, mean)

##### Minimum-Wage Study Data Example #####
## Eliminating issues of confounding bias in observational data ##

minwage <- write.csv(minwage, "minwage.csv") 
minwage <- read.csv("minwage.csv") # load the data
minwage  <- minwage [, -1]

dim(minwage) # dimension of data

summary(minwage) # summary of data

##subsetting the data into two states

minwageNJ <-subset(minwage, subset = (location != "PA"))
minwagePA <-subset(minwage, subset = (location =="PA"))

## proportion of restaurants whose wage is less than $5.05
mean(minwageNJ$wageBefore < 5.05) # NJ before

mean(minwageNJ$wageAfter < 5.05) # NJ after

mean(minwagePA$wageBefore < 5.05) # PA before

mean(minwagePA$wageAfter < 5.05) # PA after

## create a variable for proportion of full-time employees in NJ and PA
minwageNJ$fullPropAfter <- minwageNJ$fullAfter / (minwageNJ$fullAfter + minwageNJ$partAfter)
minwagePA$fullPropAfter <- minwagePA$fullAfter / (minwagePA$fullAfter + minwagePA$partAfter)
##compute the difference-in-means
mean(minwageNJ$fullPropAfter) - mean(minwagePA$fullPropAfter)

## examine possible confounding factors

# Chekc type of chain resturant 

prop.table(table(minwageNJ$chain))

prop.table(table(minwagePA$chain))

## subset Burger King only

minwageNJ.bk <- subset(minwageNJ, subset = (chain == "burgerking"))
minwagePA.bk <- subset(minwagePA, subset = (chain == "burgerking"))

## comparison of full-time eployment rates
mean(minwageNJ.bk$fullPropAfter) -  mean(minwagePA.bk$fullPropAfter)

## check location

minwageNJ.bk.subset <- 
  subset(minwageNJ.bk, subset = ((location != "shoreNJ") & (location != "centralNJ")))

mean(minwageNJ.bk.subset$fullPropAfter) - mean(minwagePA.bk$fullPropAfter)

## Check pre - and post treatments measurements to using the control as the counter factual you 
## are comparing to 

## full-time employment proportion in the previous period for NJ
minwageNJ$fullPropBefore <- minwageNJ$fullBefore / (minwageNJ$fullBefore + minwageNJ$partBefore)
## mean difference between before and after the minimum wage increase

NJdiff <- mean(minwageNJ$fullPropAfter) - mean(minwageNJ$fullPropBefore)
NJdiff

## cross-section comparison between NJ and PA

median(minwageNJ$fullPropAfter) -  median(minwagePA$fullPropAfter)

## before and after comparison

NJdiff.med <-   median(minwageNJ$fullPropAfter) -   median(minwageNJ$fullPropBefore)
NJdiff.med

## median difference-in-differences

PAdiff.med <-   median(minwagePA$fullPropAfter) -   median(minwagePA$fullPropBefore)
NJdiff.med - PAdiff.med

##### Descriptive Statistics for a single variable ######

## summary shows quartiles as well as minimum, maximum, and mean 
summary(minwageNJ$wageBefore)

summary(minwageNJ$wageAfter)

##Interquartile range

IQR(minwageNJ$wageBefore)
IQR(minwageNJ$wageAfter)

## cross-section comparison between NJ and PA

median(minwageNJ$fullPropAfter) -  median(minwagePA$fullPropAfter)

## before and after comparison

NJdiff.med <-   median(minwageNJ$fullPropAfter) -   median(minwageNJ$fullPropBefore)
NJdiff.med

## median difference-in-differences

PAdiff.med <-   median(minwagePA$fullPropAfter) -   median(minwagePA$fullPropBefore)
NJdiff.med - PAdiff.med  



## summary shows quartiles as well as minimum, maximum, and mean 
summary(minwageNJ$wageBefore)

summary(minwageNJ$wageAfter)

##Interquartile range

IQR(minwageNJ$wageBefore)
IQR(minwageNJ$wageAfter)


## deciles (10 groups)

quantile(minwageNJ$wageBefore, probs = seq(from = 0, to =1, by =0.1))

quantile(minwageNJ$wageAfter, probs = seq(from = 0, to =1, by =0.1))

## standard deviation
sd(minwage$fullPropBefore)
sd(minwage$fullPropAfter)

##variance 
var(minwage$fullPropBefore)
var(minwage$fullPropAfter)