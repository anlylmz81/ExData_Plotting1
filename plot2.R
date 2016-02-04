
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


## generate plot2
with(data,plot(data$DateTime,data$Global_active_power,type="l",
     xlab="", ylab="Global Active Power (kilowatts)"))


## save to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
