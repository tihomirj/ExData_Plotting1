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


png("plot3.png", width=480, height=480)

plot(datetime, SubMetering1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, SubMetering2, type="l", col="red")
lines(datetime, SubMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))

dev.off()
