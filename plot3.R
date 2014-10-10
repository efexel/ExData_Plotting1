## Coursera - Data Science - Exploratory Data Analysis
## Course Project 1 - plot3

# This script assume that the input file is in the current working directory
# and writes the resulting plot to the same directory.

# Input file comes from: Data from "UC Irvine Machine Learning Repository"
# URL: http://archive.ics.uci.edu/ml/
# File URL:  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##### Configuration and setup
#setwd("~/dsedacp1")
require("sqldf")
input_file <- "household_power_consumption.txt"
output_file <- "plot3.png"
width <- 480
height <- 480

# Read data, filtering to just the 2 dates we want
fh <- file(input_file)
data <- sqldf(
    "SELECT
        Date, Time, Global_active_power,
        Sub_metering_1, Sub_metering_2, Sub_metering_3
     FROM fh
     WHERE Date IN ('1/2/2007', '2/2/2007')",
     file.format = list(sep = ";", header = TRUE))
close(fh)

# Convert dates
data$DateTime <- as.POSIXct(
    paste(as.Date(strptime(data$Date, "%d/%m/%Y")), data$Time))

# Open PNG file
png(file = output_file, width=width, height=height)
# Create plot
plot(data$DateTime, data$Sub_metering_1, type="l",
    xlab="", ylab="Energy sub metering", col="black")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty=1, lwd=2.5, col=c("black", "red", "blue"))
# Close PNG file
dev.off()




