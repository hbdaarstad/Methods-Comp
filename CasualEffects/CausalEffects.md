## Causal Effects and the Counterfactual

Causal Inference is a comparison between the factual and the
counterfactual.

-   The factual can be observed while the counter factual can NOT be
    observed

-   The inability to observe the counterfactual is the fundamental
    problem of causal inference

Treatment variable (T): a key variable of interest

-   causes a change in an outcome variable, Y

To determine a whether the treatment variable of interest causes a
change in the potential outcome values, two possible outcomes must be
observed and they would be realized in the presence and absence of the
treatment, denoted as Y(1) and Y(0).

-   Y<sub>i</sub>(1) is the potential outcome under the treatment
    condition for the *i*th observation

-   T<sub>i</sub> is the treatment variable for the same observation

The causal effect of T<sub>i</sub> and Y<sub>i</sub> as the difference
between these two potential outcomes, Y<sub>i</sub>(1) -
Y<sub>i</sub>(0)

-   The fundamental problem of causal inference is that we observe only
    one of the two potential outcomes and which potential outcome is
    observed depends on the treatment states, formally, the observed
    outcome Y<sub>i</sub> is equal to Y<sub>i</sub>(T<sub>i</sub>).

## Randomized Controlled Trails

Randomized controlled trails (RCTs) is when researchers randomly assign
the treatment/control

-   regarded as the gold standard for establishing the effects of a
    treatment variable and quantify uncertainty.

-   the randomization of the the treatment enables the estimation of the
    average treatment effect (ATE)

### Sample Average Treatment Effect (SATE)

The **sample avarage treatment effect** or SATE is defined as the
sampling average of the individual-level causal effects,
Y<sub>i</sub>(1) - Y<sub>i</sub>(0):
$$ SATE = \frac{1}{n}{\sum^n\_{i=1}}{Y_i(1) - Y_1(0)} $$
*n* is the sample size and $\sum^n\_{i=1}$ is the summation opperator
from the first observation, *i* = 1, to the final *i* = *n*

To estimate the counter factual, the observation of the average outcome
of the control group can be used to estimate the average counter
factual.

-   *Difference-in-means* is the difference int he average outcome
    between the treatment and control groups
-   HOWEVER it is important to determine the validity of the estimate

Ensuring randomization of the treatment/control the in determining
validity of the estimates.

**Randomized controlled trail (RCT)** a unit is randomly assigned either
to the treatment or the control group. The randomization of the of the
treatment assignment ensures the average difference in the outcome
between treatment and control groups are attributed solely to the
treatment because the two groups on average are idential to each other.
Essentially it will ensure the interal validity of the study.

**Internal Validity** is defined as the extent to which the causal
assumptions are satisfied in the study **External Validity** is defined
as the extent in whether the conclusions can be generalized beyond the
study.

RCTs can have external validity issues such as *sample selection bias* -
the issues of making the sample not being representative of the target
population

Another issue that can causes problems for RCTs is the *Hawthrone
Effect*. The issue of whether the subjects of the study may behave
differently if the are aware of being observed by researchers.

**Hawthorne effect** is the phenomenon where the study subjects behave
differently because they know they are being observed

### Social Pressure Experiment Data Example

In the study there were three treatment groups: voters who receive
either the social pressure messages, the civic duty message, or the
Hawthorne effect message. The control group receives no message.
Researchers randomly assigned eacher voter to one of the four groups and
examined whether the voter turnout was different across the groups.

``` r
social <- read.csv("social.csv") # load the data
summary(social) # summarize the data
```

    ##        X              sex             yearofbirth    primary2004    
    ##  Min.   :     1   Length:305866      Min.   :1900   Min.   :0.0000  
    ##  1st Qu.: 76467   Class :character   1st Qu.:1947   1st Qu.:0.0000  
    ##  Median :152934   Mode  :character   Median :1956   Median :0.0000  
    ##  Mean   :152934                      Mean   :1956   Mean   :0.4014  
    ##  3rd Qu.:229400                      3rd Qu.:1965   3rd Qu.:1.0000  
    ##  Max.   :305866                      Max.   :1986   Max.   :1.0000  
    ##    messages          primary2006         hhsize     
    ##  Length:305866      Min.   :0.0000   Min.   :1.000  
    ##  Class :character   1st Qu.:0.0000   1st Qu.:2.000  
    ##  Mode  :character   Median :0.0000   Median :2.000  
    ##                     Mean   :0.3122   Mean   :2.184  
    ##                     3rd Qu.:1.0000   3rd Qu.:2.000  
    ##                     Max.   :1.0000   Max.   :8.000

Using tapply() we can compute the turnout for each group and by
subtracting the basleline turnout from the control group givers us the
average causal effect.

``` r
## turnout for each group 
tapply(social$primary2006, social$messages, mean)
```

    ## Civic Duty    Control  Hawthorne  Neighbors 
    ##  0.3145377  0.2966383  0.3223746  0.3779482

``` r
## turnout for control group 
mean(social$primary2006[social$messages=="Control"])
```

    ## [1] 0.2966383

``` r
## subtract control group turnout from each group
tapply(social$primary2006, social$messages, mean) - mean(social$primary2006[social$messages=="Control"])
```

    ## Civic Duty    Control  Hawthorne  Neighbors 
    ## 0.01789934 0.00000000 0.02573631 0.08130991

This shows that naming-and-shaming GOTV message increases turnout by 1.8
percent. A stronger effect than the hawtherone effect and civic duty
messages.

Finally to determine whether the RCT was successful there shouldn’t be
large differences across the groups in regards to pretreatment variables
such as age, turnout int he previous primary election, and household
size.

``` r
social$age <- 2006 - social$yearofbirth # create age variable
tapply(social$age, social$messages, mean)
```

    ## Civic Duty    Control  Hawthorne  Neighbors 
    ##   49.65904   49.81355   49.70480   49.85294

``` r
tapply(social$primary2004, social$messages, mean)
```

    ## Civic Duty    Control  Hawthorne  Neighbors 
    ##  0.3994453  0.4003388  0.4032300  0.4066647

``` r
tapply(social$hhsize, social$messages, mean)
```

    ## Civic Duty    Control  Hawthorne  Neighbors 
    ##   2.189126   2.183667   2.180138   2.187770

Overall, the differences in the pretreatment variables are negligible
across groups.

## Observational Studies

**Observational Studies** researchers do not conduct an intervention
rather researchers observe naturally occurring events and collect and
analyze the data.

-   *interval validity* tends to be more comprised compared to RCTs, but
    *external validity* tends to be stronger.

### Minimum-Wage Study Data Example

Using a observational data on the impact of rasing minimum wage on the
employment in the fast food industry in 1992, we can examine whether an
increase in minimum wage decreased employment as economic theory
predicts.

New Jersey receives the treatment (has a wage increase) while
Pennsylvania recieves the control (now wage increase).

``` r
minwage <-read.csv("minwage.csv") # load the date
minwage  <- minwage [, -1] # remove first column
dim(minwage) # dimension of data
```

    ## [1] 358   8

``` r
summary(minwage) # summary of data
```

    ##     chain             location           wageBefore      wageAfter    
    ##  Length:358         Length:358         Min.   :4.250   Min.   :4.250  
    ##  Class :character   Class :character   1st Qu.:4.250   1st Qu.:5.050  
    ##  Mode  :character   Mode  :character   Median :4.500   Median :5.050  
    ##                                        Mean   :4.618   Mean   :4.994  
    ##                                        3rd Qu.:4.987   3rd Qu.:5.050  
    ##                                        Max.   :5.750   Max.   :6.250  
    ##    fullBefore       fullAfter        partBefore      partAfter    
    ##  Min.   : 0.000   Min.   : 0.000   Min.   : 0.00   Min.   : 0.00  
    ##  1st Qu.: 2.125   1st Qu.: 2.000   1st Qu.:11.00   1st Qu.:11.00  
    ##  Median : 6.000   Median : 6.000   Median :16.25   Median :17.00  
    ##  Mean   : 8.475   Mean   : 8.362   Mean   :18.75   Mean   :18.69  
    ##  3rd Qu.:12.000   3rd Qu.:12.000   3rd Qu.:25.00   3rd Qu.:25.00  
    ##  Max.   :60.000   Max.   :40.000   Max.   :60.00   Max.   :60.00

First, we determine whether minimum-wage actually increases in NJ after
the passage of the law that increases wages and then calculate the
proportion of resturants in each state with hourly wages less than the
minimum wage in NJ, $5.05.

``` r
##subsetting the data into two states

minwageNJ <-subset(minwage, subset = (location != "PA"))
minwagePA <-subset(minwage, subset = (location =="PA"))

## proportion of restaurants whose wage is less than $5.05
mean(minwageNJ$wageBefore < 5.05) # NJ before
```

    ## [1] 0.9106529

``` r
mean(minwageNJ$wageAfter < 5.05) # NJ after
```

    ## [1] 0.003436426

``` r
mean(minwagePA$wageBefore < 5.05) # PA before
```

    ## [1] 0.9402985

``` r
mean(minwagePA$wageAfter < 5.05) # PA after
```

    ## [1] 0.9552239

Finally by comparing the difference in means of the proportion of
employment in each state before and after the wage increase the results
of the study suggest that the increase in mimum wage has no negative
impact on employment.

``` r
## create a variable for proportion of full-time employees in NJ and PA
minwageNJ$fullPropAfter <- minwageNJ$fullAfter / (minwageNJ$fullAfter + minwageNJ$partAfter)
minwagePA$fullPropAfter <- minwagePA$fullAfter / (minwagePA$fullAfter + minwagePA$partAfter)
##compute the difference-in-means
mean(minwageNJ$fullPropAfter) - mean(minwagePA$fullPropAfter)
```

    ## [1] 0.04811886

The key assumption for observational studies is that the treatment and
control groups are comparable with respect to everything related to the
outcome other than the treatment.

The *pretreatment variables* associated with both the treatment and
outcome variables are known as *confounders*.

**Confounders** are variables that are realized prior to the
administration of the treatment thus not causally affect by the
treatment but can possibly affect who recieves the treatment or
influence the outcome of the treatment.

Essentially, confounders are variables associated with the treatment and
outcome variables which can lead to a source of **confounding bias** in
the estimation of the treatment effect.

-   Confounding bias can be the result of self-selection into the
    treatment group known as **selection bias** which can often occur in
    observational studies because researchers do not determine who
    receives the treatment.

-   The lack of control of treatment assignment can result in
    self-selection bias

However, the possibility of confounding can be never be ruled out, but
researchers can sastiticaly control by adjusting confounders using
statistical procedures.

### Continuing Minimum Wage Study Example

One way to adjust for confounders is to use a statistical method called
*subclassification* by making the treatment and control groups as
similar as possible by comparing within a subset of observations defined
by shared values inn pretreatment variables or a subclass.

To begin the analysis first I will check the proportions of different
fast-food restaurant chains using the prop.table(functions (takes the
main output of table() as the input and converts them to proportions.

``` r
prop.table(table(minwageNJ$chain))
```

    ## 
    ## burgerking        kfc       roys     wendys 
    ##  0.4054983  0.2233677  0.2508591  0.1202749

``` r
prop.table(table(minwagePA$chain))
```

    ## 
    ## burgerking        kfc       roys     wendys 
    ##  0.4626866  0.1492537  0.2238806  0.1641791

The result shows that PA has more Burger King restaurants than NJ.
Therefore, next we will compare the full-time employment rate between NJ
and PA burger king restaurants after the increase in the minimum wage.

``` r
## subset Burger King only

minwageNJ.bk <- subset(minwageNJ, subset = (chain == "burgerking"))
minwagePA.bk <- subset(minwagePA, subset = (chain == "burgerking"))

## comparison of full-time eployment rates
mean(minwageNJ.bk$fullPropAfter) -  mean(minwagePA.bk$fullPropAfter)
```

    ## [1] 0.03643934

Since the results are similar then the type of fast-food chain is not a
confounding factor. Another factor is location, such as NJ restaurants
closer to the PA border could be getting more employees because of the
higher wage increase. Therefore the next step is to address this
possible confounding bias.

``` r
minwageNJ.bk.subset <- 
subset(minwageNJ.bk, subset = ((location != "shoreNJ") & (location != "centralNJ")))

mean(minwageNJ.bk.subset$fullPropAfter) - mean(minwagePA.bk$fullPropAfter)
```

    ## [1] 0.03149853

Again the results are similar therefore location is not a confounding
factor.

Overall, confounding bias can be reduced through statistical control.

This example is a difference-in difference design. Comparing the pre-
and posttreatments measurements.

``` r
 ## full-time employment proportion in the previous period for NJ
minwageNJ$fullPropBefore <- minwageNJ$fullBefore / (minwageNJ$fullBefore + minwageNJ$partBefore)
 ## mean difference between before and after the minimum wage increase
 
 NJdiff <- mean(minwageNJ$fullPropAfter) - mean(minwageNJ$fullPropBefore)
 NJdiff
```

    ## [1] 0.02387474

The key assumption behind the DiD design is that the outcome variable
follows the parallel trend in the absence of the treatment.

Furthermore, the \*\* Difference-in-Differences\*\* (DiD) design uses
the following estimate of the sample average treatment effect for the
treated (SATT):

$$ SATE = (\overline{Y}^{After}\_{treated} - \overline{Y}^{Before}\_{treated}) - (\overline{Y}^{After}\_{control} - \overline{Y}^{Before}\_{control}) $$

The DiD desing fails and is an invalid estimate when time trend of the
counterfactual outcome for the treatment group is not parallel to th
eobserved time trend for the control group.

## Descriptive Statistics for a Single Variable

This section numerically summarizes the dsitribution of a single
variable using descriptive statistics.

Quanitiles are defined as a set of obsevrations divided into groups
based upon the magnitude of the variables.

-   An example of a quantile is the *median* (data is divided into two
    groups, lower and higher values)

The **median** is defined as:

$$ median = \begin{cases} x\_{\frac{n + 1}{2}} & \text{if n is odd} \\\\ \frac{1}{2}(x\_{\frac{n}{2}} + x\_{\frac{n + 1}{2}}) &  \text{if n is even} \end{cases} $$
  
where x<sub>(i)</sub> denotes the value of the *i*th the smallest
observation for variable *x* and *n* is the sample size. Median is less
sensitivities to outliers than the **mean** and hence is a more robust
measure of the center of the distribution.

``` r
## cross-section comparison between NJ and PA

median(minwageNJ$fullPropAfter) -  median(minwagePA$fullPropAfter)
```

    ## [1] 0.07291667

``` r
## before and after comparison

NJdiff.med <-   median(minwageNJ$fullPropAfter) -   median(minwageNJ$fullPropBefore)
NJdiff.med
```

    ## [1] 0.025

``` r
## median difference-in-differences

PAdiff.med <-   median(minwagePA$fullPropAfter) -   median(minwagePA$fullPropBefore)
NJdiff.med - PAdiff.med  
```

    ## numeric(0)

To see more description of the distribution we can divide the data into
four groups. The first quartile (or lower quartile) in which 25% of the
observations value and the third or upper quartile includes 75%, the
second quartile is the median.

``` r
## summary shows quartiles as well as minimum, maximum, and mean 
summary(minwageNJ$wageBefore)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    4.25    4.25    4.50    4.61    4.87    5.75

``` r
summary(minwageNJ$wageAfter)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   5.000   5.050   5.050   5.081   5.050   5.750

``` r
##Interquartile range

IQR(minwageNJ$wageBefore)
```

    ## [1] 0.62

``` r
IQR(minwageNJ$wageAfter)
```

    ## [1] 0

The quantile() function can generate any quantiles by specifying the
probs argument. Furthermore the functions takes a sequence of
probabilities and indicates how the data should be divided up.

``` r
## deciles (10 groups)

quantile(minwageNJ$wageBefore, probs = seq(from = 0, to =1, by =0.1))
```

    ##   0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
    ## 4.25 4.25 4.25 4.25 4.50 4.50 4.65 4.75 5.00 5.00 5.75

``` r
quantile(minwageNJ$wageAfter, probs = seq(from = 0, to =1, by =0.1))
```

    ##   0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
    ## 5.00 5.05 5.05 5.05 5.05 5.05 5.05 5.05 5.05 5.15 5.75

Quantiles represent a set of data values that divide observations into a
certain number of equally sized groups. They include quartiles (dividing
the observations into 4 groups) and percentiles (100 groups).

-   25th percentile = lower quartile;
-   50th percentile = median;
-   75th percentile = upper quartile;

The difference between the upper and lower quartiles is called the
**interquartile range** and measures the spread of a distribution.

*Standard deviation* measures the average deviation from the mean and is
defined as:

$$ \text{standard deviation} = \sqrt{\frac{1}{n}\sum^n\_{i=1}(x_i -\overline{x})^2} \space \text{or} \space \sqrt{\frac{1}{n-1}\sum^n\_{i=1}(x_i -\overline{x})^2} $$

$\overline{x}$ represents the sample mean and n is the sample size. The
square of the standard deviation is the variance. The **variance** is
the average standard deviation from the mean.

To compute the standard deviation and variance we can use functions sd()
and var().

``` r
## standard deviation
sd(minwageNJ$fullPropBefore)
```

    ## [1] 0.2304592

``` r
sd(minwagePA$fullPropAfter)
```

    ## [1] 0.2472422

``` r
##variance 
var(minwageNJ$fullPropBefore)
```

    ## [1] 0.05311145

``` r
var(minwagePA$fullPropAfter)
```

    ## [1] 0.06112868
