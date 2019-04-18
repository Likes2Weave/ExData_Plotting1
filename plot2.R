## Overall goal: Examine how household energy usage varies using the base plotting system.
## over the dates 2007-02-01 and 2007-02-02.

## packages
library(dplyr) ## mutate
library(lubridate) ## convert strings to date/time, more flexible

## Reconstruct plot2 (line graph of Global Active Power vs time )
## Construct the plot 
## save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
## This program seems to run slowly ...

## Read in the data set
## Think ahead, set na.string = "?" to tidy NAs and prevent numerics imported as char, 
household_power_consumption <- read.csv("~/GitHub/datasciencecoursera/Course4/household_power_consumption.txt", sep=";", na.strings = "?")

## Since we do not need ALL of these rows, extract only the data from
## 1) 2007-02-01 through 2007-02-02 (YMD)
## 2) Time
## 3) Global_active_power

## Subset by target columns
household_date_time_gap <- select(household_power_consumption, c(Date, Time,Global_active_power))

## Date & Time were read in as Factors
## Create datetime variable with lubridate tools, select only required columns
household_power_Date_Time <- mutate(household_date_time_gap, datetime = dmy_hms(paste(Date, Time)))

## Subset by target dates
target_dates <- subset(household_power_Date_Time, (date(datetime) == "2007-02-01" | date(datetime) == "2007-02-02"), select = c(datetime, Global_active_power))
## target_dates has 2880 observations of 2 variables: Global_active_power and datetime

## Open PNG device; create 'plot2.png'
png(file = "plot2.png")  
## Create plot and send to a file (no plot appears on screen)

## sample plot2 was a line graph type="l"
##  in black (default)
##  no title (main="")
##  y axis labeled: "Global Active Power"
##  x axis ticks are days (default)

plot(target_dates, type = "l", main = "", ylab="Global Active Power")

dev.off()  ## Close the png file device
