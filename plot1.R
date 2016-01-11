png(filename = "plot1.png", width = 480, height = 480, units = "px")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
consumption <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?")
unlink(temp)
#converting the Date column from factor, to a Date object
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
first_day = as.Date("1/2/2007", format = "%d/%m/%Y")
second_day = as.Date("2/2/2007", format = "%d/%m/%Y")
#creating a subset which includes only the interseting dates, and the required column "Global_active_power"
consumption_2_Days <- subset(consumption, Date>=first_day&Date<=second_day, select=c(Global_active_power))
hist(consumption_2_Days$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (killowatts)", col = "red")
dev.off()