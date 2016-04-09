plot4<-function(){
library(chron)
library(data.table)
#Set English text
Sys.setlocale("LC_TIME","English")
#torn off warnings
	warn<-getOption("warn")
	options(warn=-1)

#Read data from file, zip must be unpack in working dirrectory 
 rf<-fread("./exdata-data-household_power_consumption/household_power_consumption.txt",
	sep=";")
#do not work, colClasses=c("Date","Date","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
#make appropriate data format
	rft<-rf
	rft$Date=as.Date(rft$Date, "%d/%m/%Y")
	rft$Time<-chron(times=rft$Time)
            #make numeric class
	rft<-rft[,lapply(.SD, as.numeric),by=c("Date","Time")]
#Filter dates 2007-02-01 and 2007-02-02
	rf2<-rft[rft$Date %in% as.Date(c("2007-02-01","2007-02-02"))]
#Create column with Date&Time
	rf2$wDay<-as.POSIXct(paste(rf2$Date,rf2$Time, format="%Y-%m-%d %H:%M:%S"))

#Plot on the screen
par(mfrow=c(2,2))
plot(rf2$wDay, rf2$Global_active_power, type="l", xlab="",ylab="Glabal Active Power(kilowatts)")
plot(rf2$wDay, rf2$Voltage, type="l", xlab="datetime",ylab="Voltage")

plot(rf2$wDay, rf2$Sub_metering_1, 
		type="l", 
		ylim=range(c(rf2$Sub_metering_1,rf2$Sub_metering_2, rf2$Sub_metering_3)),
		xlab="",ylab=""
)
par(new=TRUE) 
plot(rf2$wDay, rf2$Sub_metering_2,
		type="l",
		axes=FALSE, col="red",
		ylim=range(c(rf2$Sub_metering_1,rf2$Sub_metering_2, rf2$Sub_metering_3)),
		xlab="",ylab=""
)
par(new=TRUE) 
plot(rf2$wDay, rf2$Sub_metering_3, 
		type="l",
		axes=FALSE, col="blue",
		ylim=range(c(rf2$Sub_metering_1,rf2$Sub_metering_2, rf2$Sub_metering_3)),
		
 xlab="",ylab="Energy sub metering")
 legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"),cex=0.65)

plot(rf2$wDay, rf2$Global_reactive_power, type="l", xlab="datetime",ylab="Glabal Rective Power")


#Copy plot on png
dev.copy(png,file="plot4.png")
dev.off()

#torn on warnings
options(warn=warn)

}