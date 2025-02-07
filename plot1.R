library(data.table)
library(dplyr)


# Load the data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "consumo.zip", method = "curl")
unzip("consumo.zip", exdir = "consumo")
list.files("consumo")


# Keep only the data from 01/feb/2007 and 02/feb/2007
consumo<-fread("consumo/household_power_consumption.txt", sep = ";", 
      header = TRUE, stringsAsFactors = FALSE)[Date %in% c("1/2/2007", "2/2/2007")]


# Graph 1
png(file = "plot1.png", width=480,height=480) # launch png device
consumo$gap <- as.numeric(consumo$Global_active_power)
with(consumo, hist(gap, col="red", main="Global Active Power", 
                   xlab="Global Active Power (kilowatts)"))
dev.off() # close device




