library(dplyr)

if(!file.exists("data/household_power_consumption.zip"))
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/household_power_consumption.zip", method = "curl")

if(!file.exists("data/household_power_consumption.txt"))
    unzip("data/household_power_consumption.zip", exdir = "data")

data <- 
    read.csv(file = "data/household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";") %>%    
    transform(FullDate = strptime(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")) %>%
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"), as.Date("2007-02-02", format = "%Y-%m-%d"))) %>%    
    transform(Day = weekdays(FullDate, abbreviate = TRUE))

png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")

with(data, plot(FullDate, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data, lines(FullDate, Sub_metering_1, col = "black"))
with(data, lines(FullDate, Sub_metering_2, col = "red"))
with(data, lines(FullDate, Sub_metering_3, col = "blue"))

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1))

dev.off()