## Read in the dataset, converting the first column to a Date object, delete temp file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, "curl")
data <- read.table(unz(temp,"household_power_consumption.txt"), sep = ";", na.strings = c("?"),
                   colClasses= c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric',
                                 'numeric', 'numeric', 'numeric'), header=TRUE)
unlink(temp)
## Setup Graphics Device (png 480x480)
png(filename="plot4.png", width=480, height=480)
## Subset the data table to the days we're interested in
studyData <- data[which(data$Date=="1/2/2007" | data$Date == "2/2/2007"), ]
## Merge the date and time columns into a POSIXlt datetime column
studyData$timestamp <- strptime(paste(studyData$Date, studyData$Time), format = "%d/%m/%Y %H:%M:%S")
## Create plot with display options - set to a 2x2, add charts
par(mfcol = c(2,2))
plot(studyData$timestamp, studyData$Global_active_power, type="l", ylab="Global Active Power (kilowatts)",
     col="black", fg="black", xlab="")
plot(studyData$timestamp, studyData$Sub_metering_1, type="l", fg="black", col="black", ylab="Energy Sub Metering", xlab = "")
lines(studyData$timestamp, studyData$Sub_metering_2, col="red")
lines(studyData$timestamp, studyData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.col = "black", col = c("black", "red", "blue"),
         lty= 1)
plot(studyData$timestamp, studyData$Voltage, type="l", ylab="Voltage", xlab="timestamp", col="black", fg="black")
plot(studyData$timestamp, studyData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="timestamp", col="black", fg="black")
## Turn off graphics device to finish writing and closing the file
dev.off()