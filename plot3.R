## Overall goal: Examine how household energy usage varies using the base plotting system.
## over the dates 2007-02-01 and 2007-02-02.

## packages
library(dplyr) ## mutate
library(lubridate) ## convert strings to date/time, more flexible

## Reconstruct plot3 (line graph of Energy Sub Metering_1,_2,_3 vs time )
## Construct the plot 
## save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

## Read in the data set
## Think ahead, set na.string = "?" to tidy NAs and prevent numerics imported as char, 
household_power_consumption <- read.csv("~/GitHub/datasciencecoursera/Course4/household_power_consumption.txt", sep=";", na.strings = "?")

## Since we do not need ALL of these rows, extract only the data from
## 1) 2007-02-01 through 2007-02-02 (YMD)
## 2) Time
## 3) Sub_metering_1, _2, _3

## Subset by target columns
household_date_time_gap <- select(household_power_consumption, c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))

## Date & Time were read in as Factors
## Create datetime variable with lubridate tools, select only required columns
household_power_Date_Time <- mutate(household_date_time_gap, datetime = dmy_hms(paste(Date, Time)))

## Subset by target dates
target_dates <- subset(household_power_Date_Time, (date(datetime) == "2007-02-01" | date(datetime) == "2007-02-02"), select = c(datetime, Sub_metering_1, Sub_metering_2, Sub_metering_3))
## target_dates has 2880 observations of 2 variables: Global_active_power and datetime

## Open PNG device; create 'plot3.png'
png(file = "plot3.png")  
## Create plot and send to a file (no plot appears on screen)

## sample plot3 was a line graph type="l"
##  in black (_1), blue (_3) & red (_2), overlayed
##  no title (main="")
##  y axis labeled: "Energy sub metering"
##  x axis ticks are days (default)
##  with a legend 

## With three plots in one, save some typing ... using "with"
## I tried par(new=TRUE), they overlay but the y-axis scales were different = a mess, was there an axis scale factor?
## Thank you https://stackoverflow.com/questions/2564258/plot-two-graphs-in-same-plot-in-r
with(target_dates, plot(datetime, Sub_metering_1, type = "l", col="black", ylab="", xlab=""))
with(target_dates, lines(datetime, Sub_metering_2, col="red", ylab="", xlab=""))
with(target_dates, lines(datetime, Sub_metering_3, col="blue", ylab="", xlab=""))
title( main = "", ylab="Energy sub metering")
legend("topright", col = c("black","red","blue"), lty=1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()  ## Close the png file device
