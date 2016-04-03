## This script exports a png containing a line graph of global active power data from
## 2/1/07 and 2/2/07 from the household power consumption data set.  The file will be 
## named plot2.png

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

## This block creates the png, writes an empty plot to it, then adds in the line for Global
## active power, then closes the png
png("plot2.png")
plot(power$datetime, power$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(power$datetime, power$Global_active_power)
dev.off()