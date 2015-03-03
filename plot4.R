# Create 'data' subdirectory, download the zip file and save it in the 'data' subdirectory
if(!file.exists("./data")) {
    dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,
              destfile = "./data/exdata_data_household_power_consumption.zip",
              method = "curl")

# unzip the file into 'data' subdirectory
unzip(zipfile = "./data/exdata_data_household_power_consumption.zip",
      overwrite = TRUE,
      exdir = "./data")

## Reading full dataset
FullData <- read.csv("./data/household_power_consumption.txt", 
                              header=T, 
                              sep=';', 
                              na.strings="?",
                              nrows=2075259,
                              check.names=F,
                              stringsAsFactors=F,
                              comment.char="",
                              quote='\"')
FullData$Date <-as.Date(FullData$Date, format="%d/%m/%Y")
SubData <- subset(FullData, subset=(Date >="2007-02-01" & Date <= "2007-02-02"))
rm(FullData)

datetime <- as.POSIXct(paste(as.Date(SubData$Date), SubData$Time))
SubMetering1 <- as.numeric(SubData$Sub_metering_1)
SubMetering2 <- as.numeric(SubData$Sub_metering_2)
SubMetering3 <- as.numeric(SubData$Sub_metering_3)
GlobalActivePower <- as.numeric(SubData$Global_active_power)
Voltage <- as.numeric(SubData$Voltage)
GlobalReactivePower <- as.numeric(SubData$Global_reactive_power)

# plot 4

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2), mar = c(4,4,2,1), oma = c(0,1,2,0))

plot(x = datetime, y = GlobalActivePower, type ="l", xlab ="", ylab="Global Active Power")

plot(x = datetime, y = Voltage, type="l", xlab ="datetime", ylab ="Voltage")

plot(x = datetime, y = SubMetering1, type="l", xlab="", ylab="Energy sub metering")
lines(x = datetime, y = SubMetering2, type="l", col="red")
lines(x = datetime, y = SubMetering3, type="l", col="blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2, bty= "n", col=c("black", "red", "blue"), cex=0.7, xjust = 1, yjust = 1)

plot(x = datetime, y= GlobalReactivePower, type="l", xlab="datetime", ylab="Global Rective Power")

dev.off()
