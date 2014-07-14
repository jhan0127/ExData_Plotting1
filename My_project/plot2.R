#subset for project
dat<-read.csv2("household_power_consumption.txt",header=TRUE, as.is=TRUE)
dat[,1]<-as.Date(dat[,1],format="%d/%m/%Y")
subdat<-subset(dat, Date == as.Date("01/02/2007",format="%d/%m/%Y") | Date == as.Date("02/02/2007",format="%d/%m/%Y"))
subdat2<-transform(subdat, Global_active_power = as.numeric(Global_active_power))
subdat2$day<-weekdays(subdat2$Date)
subdat3<-subdat2
subdat3$dateaxis<-paste(subdat2$Date,subdat2$Time,sep=" ")
subdat3$dateaxis<-strptime(subdat3$dateaxis, format="%Y-%m-%d %H:%M:%S")
#Plot2(Line Graph)
plot2<-plot(subdat3$dateaxis, subdat3$Global_active_power, type="l",main="", xlab="",ylab="Global Active Power (kilowatts)",col="black")
library(datasets)
dev.copy(png,file="plot2.png")
dev.off()