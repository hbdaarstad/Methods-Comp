## Spatial Data

Spatial data are best analyzed by visualization through *maps*.

-   spatial point data: plotted as a set of points on a map

-   spatial polygon data: a sequence of connected points on a map
    corresponding to te boundaries of certain areas

-   spatial temporal data: a set of spatial point or polygon recorded
    over time

### Example of Spatial Polygom Data

The **maps** package provides various mapping tools as well as many
spatail databases

-   using data(us.cities) each state represents a polygon whse
    boundarues can be constructed by connecting a series of points

-   the color represents who won pularity in the states (blue for Barack
    Obama and red for John McCain)

``` r
library(maps)

data(us.cities)
head(us.cities)
```

    ##         name country.etc    pop   lat    long capital
    ## 1 Abilene TX          TX 113888 32.45  -99.74       0
    ## 2   Akron OH          OH 206634 41.08  -81.52       0
    ## 3 Alameda CA          CA  70069 37.77 -122.26       0
    ## 4  Albany GA          GA  75510 31.58  -84.18       0
    ## 5  Albany NY          NY  93576 42.67  -73.80       2
    ## 6  Albany OR          OR  45535 44.62 -123.09       0

spatial points can be easily added to maps using points() function with
their longitude and latitude information as the inputs for the *x* and
*y* coordinates respectively

``` r
map(database = "usa")
capitals <- subset(us.cities, capital ==2) # subset state captials
## add points proportional using latitude and longitude 
points(x = capitals$long, y = capitals$lat, col = "blue", 
        cex = capitals$pop /500000, pch = 19)
title("us state capitals") # add a title
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-2-1.png)
\#### California Example

``` r
map(database = "state", regions = "California")
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
cal.cities <-subset(us.cities, subset = (country.etc == "CA"))
sind <- order(cal.cities$pop, decreasing = TRUE) # order by population 
top7 <- sind[1:7] # seven cities with largest population
```

now add these cities to the map using *points()* functions with their
city names using the *text()* function.

``` r
map(database = "state", regions = "California")

points(x= cal.cities$long[top7], y = cal.cities$lat[top7], pch = 19)
## add a constant to longitude to avoid overlapping with circles
text(x = cal.cities$long[top7] + 2.25,y = cal.cities$lat[top7], 
     label = cal.cities$name[top7])
title("Largest cities of California")
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-4-1.png)

## Spatial Polygon Data in R

Set the *plot* argument of the *map()* function to **FALSE** to supress
the ploting. The function will return a list object with a sequence of
coordinates saved as *x* (x-coordinate or longitude) and *y*
(y-coordinate, latitude)

``` r
usa <- map(database = "usa", plot = FALSE) # save map
names(usa) # list elements
```

    ## [1] "x"     "y"     "range" "names"

``` r
length(usa$x)
```

    ## [1] 7252

``` r
head(cbind(usa$x, usa$y)) #first five coordinates of a polygon
```

    ##           [,1]     [,2]
    ## [1,] -101.4078 29.74224
    ## [2,] -101.3906 29.74224
    ## [3,] -101.3620 29.65056
    ## [4,] -101.3505 29.63911
    ## [5,] -101.3219 29.63338
    ## [6,] -101.3047 29.64484

observe that the map of the United States consists of 7252 pairs of
coordinates, and *map()* will use them to construct a map.

**Spatial Point Data** represent the locations of events as points on a
map. **Spatial Polygon data** represent geographical areas by connecting
points on a map.

## Colors in R

R knows the names of 657 different colors,the output of the function
*colors()* will show them

``` r
allcolors <- colors()
head(allcolors)
```

    ## [1] "white"         "aliceblue"     "antiquewhite"  "antiquewhite1"
    ## [5] "antiquewhite2" "antiquewhite3"

``` r
length(allcolors)
```

    ## [1] 657

However R can produce many more color than this. The rgb() functions
creats hexadecimal colors codes from numerical values based upon the
colors *red*, *green*, and *blue*. The intensity of the colors range
from 0 to 1.

``` r
red <- rgb(red =1, green = 0, blue = 0) # red
green <- rgb(red =0, green = 1, blue = 0) # green
blue <- rgb(red =0, green = 0, blue = 1) # blue

c(red, green, blue) # results
```

    ## [1] "#FF0000" "#00FF00" "#0000FF"

``` r
black <- rgb(red =0, green = 0, blue = 0) # black
white <- rgb(red =1, green = 1, blue = 1) # white
c(black, white) # results
```

    ## [1] "#000000" "#FFFFFF"

It can also take vector inputs.

``` r
rgb(red = c(0.5, 1), green = c(0, 1), blue= c(0.5, 1))
```

    ## [1] "#800080" "#FFFFFF"

We can also make them partially transparent by using hexadecimal colors.

``` r
##semitransparent blue
blue.trans <- rgb(red = 0, green = 0, blue = 1, alpha = 0.5)
##semi-transparent black
black.trans <- rgb(red = 0, green = 0, blue = 0, alpha = 0.5)
```

Here is a plot illistarting the use of hexadecimal colors!!

``` r
plot( x = c(1,1), y = c(1, 1.2), xlim = c(0.5, 4.5), ylim=c(0.5, 4.5),
      pch = 16, cex= 5, ann = FALSE, col = black)
points(x = c(3,3), y= c(3,3.2), pch = 16, cex=5, col = blue)
# semitransparent; easy to distinguish
points(x = c(2,2), y= c(2,2.2), pch = 16, cex=5, col = black.trans)
points(x = c(4,4), y= c(4,4.2), pch = 16, cex=5, col = blue.trans)
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-10-1.png)

### Example of 2008 Presidential Election in the US

Using colors to represent the results of the election.

``` r
pres08 <- read.csv("pres08.csv")
## two-party vote share
pres08$Dem <- pres08$Obama / (pres08$Obama + pres08$McCain)
pres08$Rep <- pres08$McCain / (pres08$Obama + pres08$McCain)

## color for California
cal.color <- rgb(red = pres08$Rep[pres08$state == "CA"], 
                 blue = pres08$Dem[pres08$state == "CA"], 
                 green = 0)

## California as a blue state
map(database = "state", regions = "California", col = "blue", 
    fill = TRUE)
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-11-1.png)

``` r
## California as a purple state
map(database = "state", regions = "California", col = cal.color,
    fill = TRUE)
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-11-2.png)

``` r
## America as red and blue states
map(database = "state") # create a map
map(database = "state") # for some reason this needs to be repeated twice to get the map correct if you run markdown
for (i in 1:nrow(pres08)) {
    if ((pres08$state[i] != "HI") & (pres08$state[i] != "AK") &
        (pres08$state[i] != "DC")) {
        maps::map(database = "state", regions = pres08$state.name[i],
            col = ifelse(pres08$Rep[i] > pres08$Dem[i], "red", "blue"),
            fill = TRUE, add = TRUE)
    }
}
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-11-3.png)

``` r
## America as purple states
map(database = "state") # create a map
for (i in 1:nrow(pres08)) {
    if ((pres08$state[i] != "HI") & (pres08$state[i] != "AK") &
        (pres08$state[i] != "DC")) {
        map(database = "state", regions = pres08$state.name[i], 
            col = rgb(red = pres08$Rep[i], blue = pres08$Dem[i],
                green = 0), fill = TRUE, add = TRUE)
    }
}
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-11-4.png)

### Walmart Example

Examine the expansion of Walmart using a data set that contains spatial
and temporal information about Walmart openings from the first opening,
March 1, 1962, to August 1,2006.

Using the data set will will plot the openings on a map and creat a
legends fpr the locations by specifinyg the x and y coordinates.

Ultimately the map will show the business stratedgy for Walmart.

``` r
walmart <- read.csv("walmart.csv")

## red = WalMartStore, green = SuperCenter, blue = DistributionCenter
walmart$storecolors <- NA # create an empty vector

walmart$storecolors[walmart$type == "Wal-MartStore"] <- 
    rgb(red = 1, green = 0, blue = 0, alpha = 1/3)
walmart$storecolors[walmart$type == "SuperCenter"] <-
    rgb(red = 0, green = 1, blue = 0, alpha = 1/3)
walmart$storecolors[walmart$type == "DistributionCenter"] <-
    rgb(red = 0, green = 0, blue = 1, alpha = 1/3)

## larger circles for DistributionCenter
walmart$storesize <- ifelse(walmart$type == "DistributionCenter", 1, 0.5)

## map with legend
map(database = "state")

points(walmart$long, walmart$lat, col = walmart$storecolors, 
       pch = 19, cex = walmart$storesize)

legend(x = -120, y = 32, bty = "n", 
       legend = c("Wal-Mart", "Supercenter", "Distrib. Center"),
       col = c("red", "green", "blue"), pch = 19, # solid circles
       pt.cex = c(0.5, 0.5, 1)) # size of circles
```

![](Spatial-Data_files/figure-markdown_github/unnamed-chunk-12-1.png)
