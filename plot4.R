## Overall goal: Examine how household energy usage varies using the base plotting system.
## over the dates 2007-02-01 and 2007-02-02.

## packages
library(dplyr) ## mutate
library(lubridate) ## convert strings to date/time, more flexible

## Reconstruct plot4 which gathers plot2, plot3 and adds a plots for Voltage and Global_reactive_power
## 2X2 to a single frame
## So that plot4.R can stand alone, I run all three plots from here rather than calling functions 
## There is a lot of overlap

## Read in the data set
## Think ahead, set na.string = "?" to tidy NAs and prevent numerics imported as char, 
household_power_consumption <- read.csv("~/GitHub/datasciencecoursera/Course4/household_power_consumption.txt", sep=";", na.strings = "?")

## Construct the plot 
## save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

## Since we do not need ALL of these rows, extract only the data from 2007-02-01 through 2007-02-02 (YMD)

## Date & Time were read in as Factors
## Create datetime variable with lubridate tools. Using most of the columns (7/9), chose not to select
household_power_Date_Time <- mutate(household_power_consumption, datetime = dmy_hms(paste(Date, Time)))

## Subset by target dates
target_dates <- subset(household_power_Date_Time, (date(datetime) == "2007-02-01" | date(datetime) == "2007-02-02"))
## target_dates has 2880 observations of 10 variables

## Open PNG device; create 'plot4.png'
png(file = "plot4.png") 

## Create plot and send to a file (no plot appears on screen)
## 2X2 output
par(mfrow=c(2,2))

## position (1,1), Global Active Power, a line graph type="l"
##  in black (default)
##  no title (main="")
##  y axis labeled: "Global Active Power"
##  x axis ticks are days (default)

with(target_dates, plot(datetime, Global_active_power, type = "l", main = "", xlab="", ylab="Global Active Power"))

## position (1,2), Voltage, a line graph type="l"
##  in black (default)
##  no title (main="")
##  y axis labeled: "Voltage"
##  x axis ticks are days (default)

with(target_dates, plot(datetime, Voltage, type = "l", main = ""))

## position (2,1), Sub Metering, a line graph type="l"
##  in black (_1), blue (_3) & red (_2), overlayed
##  no title (main="")
##  y axis labeled: "Energy sub metering"
##  x axis ticks are days (default)
##  with a legend, no box

with(target_dates, plot(datetime, Sub_metering_1, type = "l", col="black", xlab="", ylab=""))
with(target_dates, lines(datetime, Sub_metering_2, col="red", ylab=""))
with(target_dates, lines(datetime, Sub_metering_3, col="blue", ylab=""))
title( main = "", ylab="Energy sub metering")
legend("topright", bty="n", col = c("black","red","blue"), lty=1,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## In position (2,2) datetime and Global_reactive_power.
##  in black (default)
##  no title (main="")
##  y axis (default)
##  x axis ticks are days (default)

with(target_dates, plot(datetime, Global_reactive_power, type = "l", main = ""))

dev.off()  ## Close the png file device
