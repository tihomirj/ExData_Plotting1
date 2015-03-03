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
GlobalActivePower <- as.numeric(SubData$Global_active_power)

# plot 1 

png("plot1.png", width=480, height=480)

hist(GlobalActivePower, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
