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
# plot 1
png(file="plot1.png")
hist(hpc_data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")
dev.off()
