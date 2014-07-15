#subset for project
dat<-read.csv2("household_power_consumption.txt",header=TRUE, as.is=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
subdat<-subset(dat, Date == as.Date("01/02/2007",format="%d/%m/%Y") | Date == as.Date("02/02/2007",format="%d/%m/%Y"))
###transform charactor vector to numerical vector for further analyses (in plot2)
subdat2<-transform(subdat, Global_active_power = as.numeric(Global_active_power))
###transform charactor vector to numerical vector for further analyses (in plot3)
subdat2<-transform(subdat, Sub_metering_1 = as.numeric(Sub_metering_1))
subdat2<-transform(subdat, Sub_metering_2 = as.numeric(Sub_metering_2))
subdat2<-transform(subdat, Sub_metering_3 = as.numeric(Sub_metering_3))
subdat2<-transform(subdat, Voltage = as.numeric(Voltage))
subdat2<-transform(subdat, Global_reactive_power = as.numeric(Global_reactive_power))
###
subdat2$day<-weekdays(subdat2$Date)
subdat3<-subdat2
subdat3$dateaxis<-paste(subdat2$Date,subdat2$Time,sep=" ") #merge two columns into one comprehensive column
subdat3$dateaxis<-strptime(subdat3$dateaxis, format="%Y-%m-%d %H:%M:%S") #transform 'charactor' into Date class (continuous data type)
#Plot4(multiple graph)
par(mfrow=c(2,2), mar=c(4,4,2,1),oma=c(0,0,2,0))
plot2<-plot(subdat3$dateaxis, subdat3$Global_active_power, type="l",main="", xlab="",ylab="Global Active Power (kilowatts)",col="black")
plot4<-plot(subdat3$dateaxis, subdat3$Voltage, type="l",main="", xlab="datetime",ylab="Voltage",col="black")
plot3<-function(x){
  with(subdat3, plot(subdat3$dateaxis,subdat3$Sub_metering_1, main="",xlab="",ylab="Energy sub metering", type="n"))
  lines(subdat3$dateaxis,subdat3$Sub_metering_1,type="l", col="black")
  lines(subdat3$dateaxis,subdat3$Sub_metering_2,type="l", col="red")
  lines(subdat3$dateaxis,subdat3$Sub_metering_3,type="l", col="blue")
}
plot3(x)
plot5<-plot(subdat3$dateaxis, subdat3$Global_reactive_power, type="l",main="",xlab="datetime",ylab="Global_reactive_power",col="black")
library(datasets)
dev.copy(png,file="plot5.png",width = 480, height = 480)
dev.off()