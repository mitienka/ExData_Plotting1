
plot3 <- function() {

# the file is supposed in the same folder as the script
file <- file.path(".","household_power_consumption.txt", fsep = .Platform$file.sep)

# this script uses the sqldf library to read only the required days from the data file
library(sqldf)

DATA <- read.csv.sql(file, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep = ";")
timechar <- paste0(DATA[,1], " ", DATA[,2])
datetime <- strptime(timechar, "%e/%m/%Y %H:%M:%S")
DATA <- cbind(DATA,datetime)

png(filename = "plot3.png", width = 480, height = 480, units = "px")

with(DATA, {
	plot(datetime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
	lines(datetime, Sub_metering_2, col="red")
	lines(datetime, Sub_metering_3, col="blue")
	legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
})

dev.off()

}