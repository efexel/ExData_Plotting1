## Coursera - Data Science - Exploratory Data Analysis
## Course Project 1 - plot3

# This script assume that the input file is in the current working directory
# and writes the resulting plot to the same directory.

# Input file comes from: Data from "UC Irvine Machine Learning Repository"
# URL: http://archive.ics.uci.edu/ml/
# File URL:  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##### Configuration and setup
setwd("~/dsedacp1")
require('sqldf')
input_file <- "household_power_consumption.txt"
output_file <- 'plot4.png'
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

# Open PNG file
png(file = output_file, width=width, height=height)
## Create plot
# Create plot with 2 rows and two cols
par(mfrow = c(2, 2))
# 1 - From plot2.R
plot(data$DateTime, data$Global_active_power, type="l",
    xlab="", ylab="Global Active Power", col="black")
# 2 - Voltage
plot(data$DateTime, data$Voltage, type="l",
    xlab="datetime", ylab="Voltage")
# 3 - Energy Submetering - From plot3.R
plot(data$DateTime, data$Sub_metering_1, type="l",
    xlab="", ylab="Energy sub metering", col="black")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty=1, lwd=2.5, col=c("black", "red", "blue"))
# 4 - Global_reactive_power
plot(data$DateTime, data$Global_reactive_power, type="l",
    xlab="datetime", ylab="Global_reactive_power")
# Close PNG file
dev.off()




