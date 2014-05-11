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
png("plot2.png")

## Plot global active power data
plot(datetime, electricPC$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Close graphics device
dev.off()