
plot4 <- function() {

# the file is supposed in the same folder as the script : ./household_power_consumption.txt
file <- file.path(".","household_power_consumption.txt", fsep = .Platform$file.sep)

# this script uses the sqldf library to read only the required days from the data file
library(sqldf)

DATA <- read.csv.sql(file, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep = ";")

# create a character vector combining date and time column
timechar <- paste0(DATA[,1], " ", DATA[,2])

# transform the charater vector into a time vector
datetime <- strptime(timechar, "%e/%m/%Y %H:%M:%S")

# add the datetime column to the data set
DATA <- cbind(DATA,datetime)

# Changing the locale to use the english weekdays
Sys.setlocale("LC_ALL","English")

# open PNG graphic device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# set global settings to position the four plots
par(mfcol = c(2,2), mar = c(4,4,4,1), oma = c(0,0,0,0))
with(DATA, {
	plot(datetime,Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
	plot(datetime,Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
	lines(datetime, Sub_metering_2, col="red")
	lines(datetime, Sub_metering_3, col="blue")
	legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, bty="n", y.intersp = 1)
	plot(datetime,Voltage, type="l")
	plot(datetime,Global_reactive_power, type="l")
})

# close graphic device
dev.off()

}