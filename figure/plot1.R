#download the data
if(!file.exists("./exdata-data-household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./exdata-data-household_power_consumption.zip",method="curl")
}
if(!file.exists("./household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip")
}
library(sqldf)
# Using csv2.sql command to read data specific for the dates
myData <- read.csv2.sql("household_power_consumption.txt", sql = 'select * from file WHERE Date = "1/2/2007" or Date ="2/2/2007"')
plot1 <- myData[,3]

#exporting to png
png("plot1.png",width=480, height= 480)

#Looking at the plot requirements, it can be seen that this is a histogram plot as the frequency is on the y-axis
hist(plot1, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()
