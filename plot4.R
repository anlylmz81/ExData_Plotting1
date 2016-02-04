
## read the data
file <- "./household_power_consumption.txt"
alldata<- read.table(file,header = TRUE,sep = ";",
                     colClasses = c("character", "character", rep("numeric",7)),na = "?")

alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")


## subset the data
filter <- alldata$Date >=as.Date("2007-02-01") & alldata$Date <=as.Date("2007-02-02")
data <- alldata[filter, ]

## convert date
DateTime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(strptime(DateTime, "%Y-%m-%d %H:%M:%S"))


## generate plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~DateTime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~DateTime, type="l", 
         ylab="Voltage", xlab="datatime")
    plot(Sub_metering_1~DateTime, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~DateTime, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
})


## save to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
