
plot1 <- function() {

# the file is supposed in the same folder as the script : ./household_power_consumption.txt
file <- file.path(".","household_power_consumption.txt", fsep = .Platform$file.sep)

# this script uses the sqldf library to read only the required days from the data file
library(sqldf)

DATA <- read.csv.sql(file, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=TRUE, sep = ";")

# open PNG graphic device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# create histogram
with(DATA, hist(Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# close graphic device
dev.off()

}