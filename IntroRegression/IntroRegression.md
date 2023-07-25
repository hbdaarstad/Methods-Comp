## The Main Challenges to Statistics

The three most difficult challenges in statistics at the following:

1.  *Generalizing from Sample to Population*

-   associated with survey sampling

1.  *Generalizing from Treatment to Control Group*

-   associated with causal inference

1.  *Generalizing from Observed Measurements to the Underlying
    Constructs of Interest*

-   did it record exactly what we would ideally like to study?

These problems are framed as problems of prediction.

Furthermore by constructing, understanding, and fitting regression
models we can help reduce these problems of prediction and make general
claims from particular data.

Regression allows research to summarize predictions on average values of
a certain outcome vary across individuals that are defined by a set of
predictors.

## Example: Elections and the Economy

First, we load the packages and data then make a scatter plot.

``` r
hibbs <- read.csv("hibbs.csv")
plot(hibbs$growth, hibbs$vote, xlab="Average recent growth in personal income", ylab="Incumbent party's vote share")
```

![](Figs/unnamed-chunk-1-1.png)

After, we estimate the regression, *y* = *a* + *b**x* + *e**r**r**o**r*
and add a fitted line.

``` r
library(rstanarm)
m1 <- stan_glm(vote ~ growth, data=hibbs, refresh=0)
plot(hibbs$growth, hibbs$vote, xlab="Average recent growth in personal income", ylab="Incumbent party's vote share")
abline(coef(m1), col="gray")
```

![](Figs/unnamed-chunk-2-1.png)

``` r
print(m1)
```

    ## stan_glm
    ##  family:       gaussian [identity]
    ##  formula:      vote ~ growth
    ##  observations: 16
    ##  predictors:   2
    ## ------
    ##             Median MAD_SD
    ## (Intercept) 46.3    1.7  
    ## growth       3.0    0.7  
    ## 
    ## Auxiliary parameter(s):
    ##       Median MAD_SD
    ## sigma 3.9    0.7   
    ## 
    ## ------
    ## * For help interpreting the printed output see ?print.stanreg
    ## * For info on the priors used see ?prior_summary.stanreg

The estimates in the first column, 46.3 nD 3.0 are the coeffiencets for
the fitted line:

*y* = 46.3 + 3.0*x*
The second column are estimates of uncertainties displaying the median
absolute deviations. The last line provides the estimate and uncertainty
of the standard deviation, essentially the scale of the variation that
is unexplained in the regression model.

Ultimately, regressions provide models of prediction and help explore
associations. Regression models help us model existing observations and
help us forecast new data through the use of continuous (or
approximately continuous) outcomes. In addition, regression models allow
researchers to see and summarize how one variable or a set of variables
predict the outcome. Furthermore, regression models are also good for
extrapolation, adjusting for known differences between the population of
interest and the sample population. Ultimately, this allows us to use
regression models to estimate treatment effects.

## Challenges in Interpreting, Understanding, and Building Regressions

There are two ways regressions are used for causal inference, adjusting
for background variables and estimating a relationship.

If we are interested in the effect of some treatment *x* on an outcome
*y*, and the data, assuming continuous measures, come from a randomized
or otherwise balanced experiment, we can fit a regression—that is, a
model that predicts *y* from *x*, while allowing for uncertainty.

Furthermore, if the predictor was binary, (0 or 1), the same idea holds.
Assuming comparability of the groups who are assigned different
treatments the regression analysis predicts the outcome of the treatment
on the estimate giving us the direct estimate of the causal effect.

These will result in direct estimates, however, they can be improved to
make the data better fit the model resulting in better predictions. Such
as considering a nonlinear modeling of the continuous treatment effect
or *interactions*. Interactions are treatment effects that vary as a
function of other predictors in the model, for example, estimating the
difference in cancer between smokers and nonsmokers. Variation is
important to understand and interactions provide us insights.

Furthermore, there are systematic differences in the experimental units
that are given the treatment or control, such as some being more
educated than average. Adjusting for background variables is essential
due to imbalance between these groups and results in more accurate
predictions for regression models. Therefore, when there is imbalance
between treated and controls on a key predictor, some adjustment should
be done.

In addition to understanding what goes in to understanding what is used
to make a good fitting regression model that makes good predictions, you
need to understands it output. Ultimately, the statistical analysis of
regression models go through the following four cycles:

-   First, building a regression model starts with the
    *y* = *a* + *b**x* + *e**r**r**o**r* with the addition of more
    predictors, interactions, and transformations.

-   Next, the model needs to be adjusted to best fit the data through
    data manipulation, programing, and algorithms that estimate
    regression coefficents and their uncertainties to improve the models
    predictive capabilities.

-   Third, using graphics, programming,a nd active investigation between
    the relationship of the measurements, parameters and objects of the
    study researchers can understand how the model fits.

-   Finally, *criticism.* Essentially, trying to figure out were the
    model is failing and struggling to provide the answers we desire to
    know.

## Classical and Bayesian Inference

As researchers we spend a lot of effort fitting models to our data and
using those models to make predictions which are preformed under various
methodological and philosophical frameworks. Howevere, there are three
concerons:

-   1.  what *information* is being used in the estimation process

-   1.  what *assumptions* are being made

-   1.  how estimates and predictions are *interpreted*, in a classical
        or Bayesian framework

### Information

The first point for any regression program is the data on an outcome
variable *y* and one or more of the predictors, *x*. Information on what
outcome and predictor variables were observed and the population they
come from should be available. Holding information about these help the
research make informed decisions on building and fitting the model to
make the best possible predictions in addition to the limitations the
model has.

### Assumptions

There are three sorts of assumptions that are essential to regression
models:

-   The function form of the relation between *x* and *y*. Typically,
    researchers assume linearity, however, research can transfrome
    predictors or outcomes or combining predictors in nonlinear or
    linear ways.

-   The assumptions of where the data came from: observations seen or
    not, those surveyed and those who choose not to respond, etc. These
    assumptions can be strong or weak depending on data.

-   The accuracy of the survey. Are survey responses accurate, can
    behavior in a lab experiment be generalized to the outside world,
    are today’s measurements predictive of what might happen tomorrow?

### Classical and Bayseian Inference

**Classical inference** os the pure summaries of data which can have
limited value as predictions. **Bayesian inference** can yield valid
predictions even with weak data, but relies on additional assumptions.

#### Classical Inference

The traditional approach to statistical analysis is based on summarizing
the information in the data, not using prior information, but getting
estimates and predictions that have well-understood statistical
properties, low bias and low variance.

An important principle of classical statistics is *conservatism:*

-   sometimes data is weak and, therefore, we can not make strong
    statements. However, we would like to be able to say, at least
    approximately, that our estimates are unbiased and our intervals
    have the advertised coverage.

The weaknesses of the classical approach arise when studies are small
and data are indirect or highly variable.

#### Bayesian Inference

**Bayesian inference** is an approach to statistics which incorporates
prior information into inferences. Bayesian analysis provides more
reasonable results and can be used to make direct predictions about
future outcomes and the results of future experiments.However, more
information is required—the “prior distribution.

## Computing Least Squares and Bayesian Regression

Using simulated data I will use to build a Bayesian regression and least
squares regression. First, I need to simulate the data and make a data
frame.

``` r
# discrete predictor variable
x<-rbinom(100, 1, 0.5)

# continuous outcome variable
y<-rnorm(100, 3, 1)

mydata <- data.frame(x,y)
```

Next, I will build my Bayesian Model.

``` r
fit <- stan_glm(y~x, data=mydata, refresh=0)
summary(fit)
```

    ## 
    ## Model Info:
    ##  function:     stan_glm
    ##  family:       gaussian [identity]
    ##  formula:      y ~ x
    ##  algorithm:    sampling
    ##  sample:       4000 (posterior sample size)
    ##  priors:       see help('prior_summary')
    ##  observations: 100
    ##  predictors:   2
    ## 
    ## Estimates:
    ##               mean   sd   10%   50%   90%
    ## (Intercept) 2.8    0.1  2.7   2.8   3.0  
    ## x           0.2    0.2  0.0   0.2   0.5  
    ## sigma       0.8    0.1  0.8   0.8   0.9  
    ## 
    ## Fit Diagnostics:
    ##            mean   sd   10%   50%   90%
    ## mean_PPD 3.0    0.1  2.8   3.0   3.1  
    ## 
    ## The mean_ppd is the sample average posterior predictive distribution of the outcome variable (for details see help('summary.stanreg')).
    ## 
    ## MCMC diagnostics
    ##               mcse Rhat n_eff
    ## (Intercept)   0.0  1.0  3894 
    ## x             0.0  1.0  3578 
    ## sigma         0.0  1.0  3385 
    ## mean_PPD      0.0  1.0  4079 
    ## log-posterior 0.0  1.0  1853 
    ## 
    ## For each parameter, mcse is Monte Carlo standard error, n_eff is a crude measure of effective sample size, and Rhat is the potential scale reduction factor on split chains (at convergence Rhat=1).

Finally, I will simulate my data using a continous predictor variable to
build my least squares model.

``` r
# continuous predictor variable
x<-rnorm(100, 1, 1)

# continuous outcome variable
y<-rnorm(100, 3, 1)

mydata <- data.frame(x,y)

fit <- lm(y~x, data=mydata, refresh=0)
summary(fit)
```

    ## 
    ## Call:
    ## lm(formula = y ~ x, data = mydata, refresh = 0)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -2.4646 -0.6648 -0.1535  0.5192  2.6841 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   3.2065     0.1540  20.824   <2e-16 ***
    ## x            -0.0247     0.1102  -0.224    0.823    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.9918 on 98 degrees of freedom
    ## Multiple R-squared:  0.0005123,  Adjusted R-squared:  -0.009687 
    ## F-statistic: 0.05023 on 1 and 98 DF,  p-value: 0.8231
