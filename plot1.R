plot1<-function(){
library(chron)
library(data.table)
#torn off warnings
	warn<-getOption("warn")
	options(warn= -1)
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
#Plot on the screen
hist(rf2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
#Copy plot on png
dev.copy(png,file="plot1.png")
dev.off()
#torn on warnings
options(warn=warn)

}