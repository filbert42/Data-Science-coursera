## This script using dplyr and tidyr package
## install.packages(c("dplyr","tidyr")) ## Uncomment this if you have not this packages installed
library(tidyr)
## Read data
data <- read.table("household_power_consumption.txt", sep = ";", header =T, 
                   colClasses = c("character", "character", rep("numeric", 7)), na = "?")
## Subset data
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]
## Unite Date and Time columns using tidyr
data <- data %>% unite(DateTime, Date, Time, sep = " ")
## convert DateTime into correct format
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
## Open png device
png(filename = "plot4.png")
## Change parameters for 4 plots in one
par(mfrow= c(2,2))
## First plot
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
## Second plot
with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
## Third plot
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, bty = "n")
## Fourth plot
with(data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
## close png device
dev.off()
