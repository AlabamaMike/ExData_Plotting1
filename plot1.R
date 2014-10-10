## Read in the dataset, converting the first column to a Date object, delete temp file
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, "curl")
data <- read.table(unz(temp,"household_power_consumption.txt"), sep = ";", na.strings = c("?"),
                   colClasses= c('myDate', 'character', 'numeric', 'numeric', 'numeric', 'numeric',
                                 'numeric', 'numeric', 'numeric'), header=TRUE)
unlink(temp)

## Setup Graphics Device (png 480x480)
png(filename="plot1.png", width=480, height=480)
## Subset the data table to the days we're interested in
studyData <- data[which(data$Date=="2007-02-01" | data$Date == "2007-02-02"), ]
## Create histograph with display options
hist(studyData$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylim= c(0,1200) )
## Turn off graphics device to finish writing and closing the file
dev.off()