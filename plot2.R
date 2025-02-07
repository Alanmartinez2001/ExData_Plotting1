library(data.table)
library(dplyr)


# Load the data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "consumo.zip", method = "curl")
unzip("consumo.zip", exdir = "consumo")
list.files("consumo")


# Keep only the data from 01/feb/2007 and 02/feb/2007 and the Global_active_power variable
consumo<-fread("consumo/household_power_consumption.txt", sep = ";", 
               header = TRUE, stringsAsFactors = FALSE)[Date %in% c("1/2/2007", "2/2/2007")]
consumo <- consumo %>%
    mutate(gpa=as.numeric(Global_active_power)) %>%
    select(gpa)


# Graph 2
png(file = "plot2.png") # launch png device
with(consumo, plot(gpa, xaxt="n", type="l", ylab= "Global Active Power (kilowatts)",
                   xlab=""))
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))
dev.off() # close device


# Save the graph