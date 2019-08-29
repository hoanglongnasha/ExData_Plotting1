require(sqldf)

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
png('plot1.png')
hist(filter_dat$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.off()


