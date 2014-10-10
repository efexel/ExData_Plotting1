## Coursera - Data Science - Exploratory Data Analysis
## Course Project 1 - plot1

# This script assume that the input file is in the current working directory
# and writes the resulting plot to the same directory.

# Input file comes from: Data from "UC Irvine Machine Learning Repository"
# URL: http://archive.ics.uci.edu/ml/
# File URL:  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##### Configuration and setup
#setwd("~/dsedacp1")
require("sqldf")
input_file <- "household_power_consumption.txt"
output_file <- "plot1.png"
width <- 480
height <- 480

# Read data, filtering to just the dates and fields we want
fh <- file(input_file)
data <- sqldf(
    "SELECT
        Date, Time, Global_active_power
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
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
# Close PNG file
dev.off()




