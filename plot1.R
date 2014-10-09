library(dplyr)

if(!file.exists("data/household_power_consumption.zip"))
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/household_power_consumption.zip", method = "curl")

if(!file.exists("data/household_power_consumption.txt"))
    unzip("data/household_power_consumption.zip", exdir = "data")

data <- 
    read.csv(file = "data/household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";") %>%
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"), as.Date("2007-02-02", format = "%Y-%m-%d")))

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()