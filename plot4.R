library(dplyr)

# download and extract files if they don't exist
if(!file.exists("data/household_power_consumption.zip"))
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/household_power_consumption.zip", method = "curl")

if(!file.exists("data/household_power_consumption.txt"))
    unzip("data/household_power_consumption.zip", exdir = "data")

# read and transform the data:
# 1 - merge date and time to create a full date and turn it into an actual Date class
# 2 - transform the original Date into an actual Date class
# 3 - filter based on Date - only for the 2 days
data <- 
    read.csv(file = "data/household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";") %>%    
    transform(FullDate = strptime(paste(Date, Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")) %>%
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"), as.Date("2007-02-02", format = "%Y-%m-%d")))

# open PNG graphic device
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")

# canvas needs to be 2X2
par(mfrow = c(2,2))

# plot the 4 graphs:
# 1 - Line plot FullDate X Global_active_power
# 2 - Line plot FullDate X Voltage
# 3 - Line plot FullDate X Sub_metering_(1,2,3) with legend
# 4 - Line plot FullDate X Global_reactive_power
with(data, {
    plot(FullDate, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    plot(FullDate, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(FullDate, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(FullDate, Sub_metering_1, col = "black")
    lines(FullDate, Sub_metering_2, col = "red")
    lines(FullDate, Sub_metering_3, col = "blue")
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), bty = "n")
    plot(FullDate, Global_reactive_power, type = "l", xlab = "datetime")
})

# close PNG graphic device
dev.off()