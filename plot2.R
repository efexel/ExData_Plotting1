## Coursera - Data Science - Exploratory Data Analysis
## Course Project 1 - plot2

# This script assume that the input file is in the current working directory
# and writes the resulting plot to the same directory.

# Input file comes from: Data from "UC Irvine Machine Learning Repository"
# URL: http://archive.ics.uci.edu/ml/
# File URL:  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##### Configuration and setup
setwd("~/dsedacp1")
require('sqldf')
input_file <- "household_power_consumption.txt"
output_file <- 'plot2.png'
width <- 480
height <- 480

# Read data, filtering to just the 2 dates we want
fh <- file(input_file)
attr(fh, "file.format") <- list(sep = ";", header = TRUE)
data <- sqldf("select * from fh where Date in ('1/2/2007', '2/2/2007')")
close(fh)
# Convert dates
data$DateTime <- as.POSIXct(
    paste(as.Date(strptime(data$Date, '%d/%m/%Y')), data$Time))

# Open PNG File
png(file = output_file, width=width, height=height)
# Create plot
plot(data$DateTime, data$Global_active_power, type="l", xlab="",
    ylab="Global Active Power (kilowatts)", col="black")
# Close PNG File
dev.off()




