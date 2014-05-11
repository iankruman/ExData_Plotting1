## Source file:
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Set file name and column classes
fileName <- "household_power_consumption.txt"
columnClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")

## Get column names from first row of file since code skips file rows when reading in data
columnNames <- as.character(read.csv2(fileName, nrows = 1, header=FALSE, colClasses = "character" ))

## Read in file, skipping days before Feb 1, 2007 and only reading in rows from the 1st and 2nd
electricPC <- read.table(fileName, header = FALSE, sep = ";", na.strings = "?", colClasses = columnClasses, skip = 66637, nrows = 2880)
names(electricPC) <- columnNames

## Create datetime data by pasting date and time together, then convert to POSIXlt
datetime <- paste(electricPC$Date, electricPC$Time, sep = " ")
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")

## Initialize png graphics device
png("plot3.png")

## Plot submetering 1 data
plot(datetime, electricPC$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" )

## Add line for submetering 2 (red)
lines(datetime, electricPC$Sub_metering_2, col = "red")

## Add line for submetering 3 (blue)
lines(datetime, electricPC$Sub_metering_3, col = "blue")

## Create legend
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Turn off graphics device
dev.off()