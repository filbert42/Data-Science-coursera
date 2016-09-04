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
png(filename = "plot3.png")
## Create plot
par(mfrow = c(1,1))
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, col = "red"))
with(data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
## close png device
dev.off()
