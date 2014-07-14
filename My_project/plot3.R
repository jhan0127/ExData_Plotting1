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
###
subdat2$day<-weekdays(subdat2$Date)
subdat3<-subdat2
subdat3$dateaxis<-paste(subdat2$Date,subdat2$Time,sep=" ") #merge two columns into one comprehensive column
subdat3$dateaxis<-strptime(subdat3$dateaxis, format="%Y-%m-%d %H:%M:%S") #transform 'charactor' into Date class (continuous data type)
#Plot3(Legend and Color graph)
with(subdat3, plot(subdat3$dateaxis,subdat3$Sub_metering_1, main="",xlab="",ylab="Energy sub metering", type="n"))
lines(subdat3$dateaxis,subdat3$Sub_metering_1,type="l", col="black")
lines(subdat3$dateaxis,subdat3$Sub_metering_2,type="l", col="red")
lines(subdat3$dateaxis,subdat3$Sub_metering_3,type="l", col="blue")
legend("topright", lty=c(1,1,1), ncol=1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
library(datasets)
dev.copy(png,file="plot3.png")
dev.off()