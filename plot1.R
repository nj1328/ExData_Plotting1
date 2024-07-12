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

hh_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

## Convert Date from character format to date format

hh_data$Date <- as.Date(hh_data$Date, "%d/%m/%Y")

## Take a subset of the data, between 2007-02-01 and 2007-02-02

hh_data <- subset(hh_data,hh_data$Date=="2007-02-01" | hh_data$Date =="2007-02-02")

## Create histogram of Global_active_power and copy to plot1.png

hist(hh_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()