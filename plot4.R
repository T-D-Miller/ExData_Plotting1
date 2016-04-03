## This script exports a png containing a matix of four plots of different power data from
## 2/1/07 and 2/2/07 from the household power consumption data set.  The file will be 
## named plot4.png

## the four plots created are as follows:
## top-left: line graph of global active power
## bottom-left: color coded line graph of sub metering data
## top-right: line graph of voltage
## bottom-right: line graph of global reactive power

## This block does the following: 1. Loads the data to a data.frame called power. 2. Combines
## the date and time columns into 1 column called date time, which is a vectore of time 
## objects 3. Adds the new datetime column as the first column in the power data.frame
## 4. Subsets the data.frame to include only 2/1/07 and 2/2/07. 5. Removes the unnecessary
## datetime object from the workspace.
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
datetime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S", tz = "UTC")
power <- cbind(datetime, power)
power <- subset(power, as.Date(datetime) == "2007-02-01" | as.Date(datetime) == "2007-02-02")
rm(datetime)

## this creates the png
png("plot4.png")

## this sets up the device to accept 4 plots
par(mfcol = c(2,2))

## top-left plot: create the empty plot, then add in the global active power line
plot(power$datetime, power$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(power$datetime, power$Global_active_power)

## bottom-left plot: create the empty plot, add in the 3 lines for the 3 sub metering
## variables, add in a legend
plot(power$datetime, power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_1)
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")

## top-right plot: create the empty plot, add in a line for the voltage data
plot(power$datetime, power$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(power$datetime, power$Voltage)

## bottom-right plot: create an empty plot, add in the line for global reactive data
plot(power$datetime, power$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(power$datetime, power$Global_reactive_power)

## Close the png 
dev.off()