## Create a filename for a local copy of the data file

projectfile <- "HH_dataset.zip"

## If the projectfile does not already exist, download the data. 

if(!file.exists(projectfile)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, projectfile, method = "curl")
}

## Check if the zip file has already been unzipped 
## (ie file "household_power_consumption.txt" exists) and if not, unzip it.

if(!file.exists("household_power_consumption.txt")) {
  unzip(projectfile)
}

## Read the data file

hh_data <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE, na.strings = "?")

## Convert Date from character format to date format

hh_data$Date <- as.Date(hh_data$Date, "%d/%m/%Y")

## Take a subset of the data, between 2007-02-01 and 2007-02-02 

hh_data <- subset(hh_data,hh_data$Date=="2007-02-01" | hh_data$Date =="2007-02-02")
hh_data$Date <- as.POSIXct(paste(hh_data$Date, hh_data$Time), 
                           format = "%Y-%m-%d %H:%M:%S")

## Create plot with the three Sub_metering variables and copy to plot3.png

with(hh_data, plot(Date, Sub_metering_1, type = "n", xaxt="n", xlab = "",
                   ylab = "Energy sub metering"))
with(hh_data, lines(Date, Sub_metering_1, type = "l"))
with(hh_data, lines(Date, Sub_metering_2, type = "l", col = "red"))
with(hh_data, lines(Date, Sub_metering_3, type = "l", col = "blue"))

axis.POSIXct(1, hh_data$Date, format = "%A", at=pretty(hh_data$Date, n=2))

legend("topright", lty = 1, col = c("black", "red", "blue"), cex=0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()