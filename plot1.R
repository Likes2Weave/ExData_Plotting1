## Overall goal: Examine how household energy usage varies using the base plotting system.
## over the dates 2007-02-01 and 2007-02-02.

## packages
library(dplyr)

## Reconstruct plot1 (histogram of Global Active Power)
## Construct the plot 
## save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

## Read in the data set
## Think ahead, set na.string = "?" to tidy NAs and prevent numerics imported as char, 
household_power_consumption <- read.csv("~/GitHub/datasciencecoursera/Course4/household_power_consumption.txt", sep=";", na.strings = "?")

## Since we do not need ALL of these rows, extract only the data from
## 1) 2007-02-01 through 2007-02-02
## 2) Global_active_power

## Date was read in as a Factor rather than a date format
## Convert factor to Date Format as.Date will return "YYYY-MM-DD"
household_power_asDate <- mutate(household_power_consumption, Date = as.Date(Date, "%d/%m/%Y"))

## Subset by target dates, select only required columns
target_dates <- subset(household_power_asDate, (Date == "2007-02-01" | Date == "2007-02-02"), select = c(Global_active_power))

## Open PNG device; create 'plot1.png'
png(file = "plot1.png")  
## Create plot and send to a file (no plot appears on screen)

## target_dates has 2880 observations of 1 variable
## sample plo1 was a histogram of 
##  12 red bars: breaks=12, col="red"
##  frequencies: freq=true
##  custom main and x axis labels

hist(target_dates$Global_active_power, breaks = 12, freq = TRUE, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()  ## Close the png file device
