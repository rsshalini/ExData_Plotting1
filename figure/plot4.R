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
myData$datetime <- strptime(datetime_temp, "%d/%m/%Y %H:%M:%S")

#exporting to png
png("plot4.png",width=480, height= 480)

#defining the plot arrangement
par(mfrow = c(2,2))
with(myData,{
  plot(datetime,Global_active_power,type="l",xlab = "", ylab="Global Active Power")
  plot(datetime, Voltage, type="l")
  plot(xrange,yrange,type="n",xlab ="",ylab="Energy Sub metering")
    #adding lines to the plot
    lines(myData$datetime, myData$Sub_metering_1,type="l",col="black")
    lines(myData$datetime, myData$Sub_metering_2,type="l",col="red")
    lines(myData$datetime, myData$Sub_metering_3,type="l",col="blue")
  legend("topright",col=c("black","blue","red"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2)
  plot(datetime, Global_reactive_power, type="l")
  })

dev.off()
