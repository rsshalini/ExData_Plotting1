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

#joining the date and time using a paste function and converting the date time using strptime function to POSIXlt POSIXt format. 

datetime_temp <- paste(myData$Date,myData$Time)
datetime <- strptime(datetime_temp, "%d/%m/%Y %H:%M:%S")

#exporting to png
png("plot2.png",width=480, height= 480)

# type l is for the line type of drawing. 
par(mar=c(3,6,1,1))
plot(datetime,myData$Global_active_power,type="l",xlab = "", ylab="Global Active Power (killowatts)") 

dev.off()
