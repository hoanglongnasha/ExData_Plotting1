require(sqldf)
require(lubridate)

if(!file.exists('household_power_consumption.txt')) {
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(url, destfile = 'data.zip')
    unzip('data.zip')
    file.remove('data.zip')
}

##Read selected data 
filter_dat <- read.csv.sql('household_power_consumption.txt', header = TRUE, sep = ';',  sql = 'select * from file where Date IN ("1/2/2007", "2/2/2007")')
base::closeAllConnections()

##Create the graph
png('plot3.png')
datetime <- as_datetime(paste(filter_dat$Date, filter_dat$Time), format = "%d/%m/%Y %H:%M:%S")
plot(datetime, filter_dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = datetime, y = filter_dat$Sub_metering_2, col = 'red')
lines(x = datetime, y = filter_dat$Sub_metering_3, col = 'blue')
legend('topright', lty = 1, col = c('black', 'red', 'blue'), legend = names(filter_dat[7:9]))
dev.off()