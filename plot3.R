## This script exports a png containing a color coded line graph of sub metering data from
## 2/1/07 and 2/2/07 from the household power consumption data set.  The file will be 
## named plot3.png

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

## this block creates the png, creates an empty plot, adds in the line fot the first,
## second, then third sub metering data columns, then adds a legend, then closes the file
png("plot3.png")
plot(power$datetime, power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_1)
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()