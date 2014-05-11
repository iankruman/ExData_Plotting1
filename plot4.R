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
png("plot4.png")

## Set graphic device to display 4 plots
par(mfrow = c(2,2))

## Plot global active power in first slot
plot(datetime, electricPC$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "" )

## Plot Voltage in second slot
plot(datetime, electricPC$Voltage, type = "l", ylab = "Voltage" )

## Plot submetering data in third slot, add lines for 2nd/3rd submetering, and create legend
plot(datetime, electricPC$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "" )
lines(datetime, electricPC$Sub_metering_2, col = "red")
lines(datetime, electricPC$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

## Plot global reactive power in fourth slot
with(electricPC, plot(datetime, Global_reactive_power, type = "l") )

## Turn off graphics device
dev.off()
