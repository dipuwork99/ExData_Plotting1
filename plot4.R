dt <- read.table("household_power_consumption.txt" , sep = ";", header = TRUE , na.strings="?")
library(dplyr)
library(lubridate)
filteredData <- subset(dt , Date %in% c("1/2/2007","2/2/2007"))
filteredData <-  filteredData %>% mutate(Date = as.Date(Date , format="%d/%m/%Y") , Global_active_power = as.numeric(Global_active_power))
filteredData <-  filteredData %>% mutate(DateTime = as.POSIXct(paste(as.Date(Date) , Time)))
filteredData <-  filteredData %>% mutate(Sub_metering_1 = as.numeric(Sub_metering_1) , Sub_metering_2 = as.numeric(Sub_metering_2) , Sub_metering_3 = as.numeric(Sub_metering_3))                     

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(filteredData, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
