#load data
if (!exists("hpc_data")){
	# load required package
	library(sqldf)

	# set column classes of the file record 
	hpc_data_classes <- c(rep("character", 2), rep("numeric", 7))

	# reading data for 1th and 2nd of Feb. 2007 into data.frame
	hpc_data <- read.csv.sql(file="household_power_consumption.txt", sql = "select * from file where Date in('1/2/2007', '2/2/2007') ", header=TRUE, sep=";", colClasses = hpc_data_classes)

	# convert dates and times into appropriate classes
	# concat time=date+time - then convert
	hpc_data$Time <- paste(hpc_data$Date, hpc_data$Time)
	hpc_data$Date <- as.Date(hpc_data$Date, format = "%d/%m/%Y")
	hpc_data$Time <- strptime(hpc_data$Time, format = "%d/%m/%Y %H:%M:%S")}

}
#plot 4
png(file="plot4.png")
par(mfrow = c(2,2))
#top-left plot
plot(hpc_data$Time, hpc_data$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
#top-right plot
plot(hpc_data$Time, hpc_data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
#bottom-left plot
plot(hpc_data$Time, hpc_data$Sub_metering_1 , type="l", ylab = "Energy sub metering", xlab = "")
lines(hpc_data$Time, hpc_data$Sub_metering_2, type="l", col = "Red")
lines(hpc_data$Time, hpc_data$Sub_metering_3, type="l", col = "Blue")
legend( "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col= c("black", "red", "blue"))
#bottom-right plot
plot(hpc_data$Time, hpc_data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()