
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


## generate plot3
with(data, {
    plot(Sub_metering_1~DateTime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## save to png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
