png(filename = "plot3.png", width = 480, height = 480, units = "px")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
consumption <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?")
unlink(temp)
#converting the Date+Time columns from factor, to a Date-Time object
consumption$DateTime <- paste(consumption$Date, consumption$Time)
consumption$DateTime <- as.POSIXct(consumption$DateTime, format = "%d/%m/%Y %H:%M:%S")
start_day = as.POSIXct("1/2/2007", format = "%d/%m/%Y")
end_day = as.POSIXct("3/2/2007", format = "%d/%m/%Y")
#creating a subset which includes only the interseting dates, and the required columns
consumption_2_Days <- subset(consumption, DateTime>=start_day&DateTime<=end_day, select=c(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3))
with(consumption_2_Days, 
     {
       plot(DateTime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "", col="black")
       lines(DateTime, Sub_metering_2, type="l", col="red")
       lines(DateTime, Sub_metering_3, type="l", col="blue")
     })
axis(1, at=1:3, labels = c("Thu", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"))
dev.off()