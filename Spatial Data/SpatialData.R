

## SPATIAL DATA ##

###### SPATIAL DATA ######

library(maps)

data(us.cities)
head(us.cities)

map(database = "usa")
capitals <- subset(us.cities, capital ==2) # subset state captials
## add points proportional using latitude and longitude 
points(x = capitals$long, y = capitals$lat, col = "blue", 
       cex = capitals$pop /500000, pch = 19)
title("us state capitals") # add a title

map(database = "state", regions = "California")

cal.cities <-subset(us.cities, subset = (country.etc == "CA"))
sind <- order(cal.cities$pop, decreasing = TRUE) # order by population 
top7 <- sind[1:7] # seven cities with largest population

map(database = "state", regions = "California")

points(x= cal.cities$long[top7], y = cal.cities$lat[top7], pch = 19)
## add a constant to longitude to avoid overlapping with circles
text(x = cal.cities$long[top7] + 2.25,y = cal.cities$lat[top7], 
     label = cal.cities$name[top7])
title("Largest cities of California")

usa <- map(database = "usa", plot = FALSE) # save map
names(usa) # list elements
length(usa$x)
head(cbind(usa$x, usa$y)) #first five coordinates of a polygon
###### COLORS #######

## colors r knows
allcolors <- colors()
head(allcolors)
length(allcolors)

## hexdeciaml colors
red <- rgb(red =1, green = 0, blue = 0) # red
green <- rgb(red =0, green = 1, blue = 0) # green
blue <- rgb(red =0, green = 0, blue = 1) # blue

c(red, green, blue) # results

black <- rgb(red =0, green = 0, blue = 0) # black
white <- rgb(red =1, green = 1, blue = 1) # white
c(black, white) # results

## vector inputs
rgb(red = c(0.5, 1), green = c(0, 1), blue= c(0.5, 1))
##semitransparent blue
blue.trans <- rgb(red = 0, green = 0, blue = 1, alpha = 0.5)
##semi-transparen black
black.trans <- rgb(red = 0, green = 0, blue =0, alpha = 0.5)

plot( x = c(1,1), y = c(1, 1.2), xlim = c(0.5, 4.5), ylim=c(0.5, 4.5),
      pch = 16, cex=5, ann = FALSE, col = black)
points(x = c(3,3), y= c(3,3.2), pch = 16, cex=5, col = blue)
# semitransparent; easy to distinguish
points(x = c(2,2), y= c(2,2.2), pch = 16, cex=5, col = black.trans)
points(x = c(4,4), y= c(4,4.2), pch = 16, cex=5, col = blue.trans)


####### EXAMPLE OF 2008 ELECTION#######

Using colors to represent the results of the election. 


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

## California as a purple state
map(database = "state", regions = "California", col = cal.color,
    fill = TRUE)

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


##### WALMART EXAMPLE ######

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
