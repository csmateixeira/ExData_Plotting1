library(dplyr)

# download and extract files if they don't exist
if(!file.exists("data/household_power_consumption.zip"))
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data/household_power_consumption.zip", method = "curl")

if(!file.exists("data/household_power_consumption.txt"))
    unzip("data/household_power_consumption.zip", exdir = "data")

# read and transform the data:
# 1 - transform the original Date into an actual Date class
# 2 - filter based on Date - only for the 2 days
data <- 
    read.csv(file = "data/household_power_consumption.txt", na.strings = "?", header = TRUE, sep = ";") %>%
    mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
    filter(Date %in% c(as.Date("2007-02-01", format = "%Y-%m-%d"), as.Date("2007-02-02", format = "%Y-%m-%d")))

# open PNG graphic device
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")

# plot the histogram for Global_active_power
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

# close PNG graphic device
dev.off()