library(data.table)
library(dplyr)


# Load the data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "consumo.zip", method = "curl")
unzip("consumo.zip", exdir = "consumo")
list.files("consumo")


# Keep only the data from 01/feb/2007 and 02/feb/2007 and the submettering variables
consumo<-fread("consumo/household_power_consumption.txt", sep = ";", 
               header = TRUE, stringsAsFactors = FALSE)[Date %in% c("1/2/2007", "2/2/2007")]
consumo <- consumo %>%
    mutate(met1=as.numeric(Sub_metering_1),
           met2=as.numeric(Sub_metering_2),
           met3=as.numeric(Sub_metering_3)) %>%
    select(met1, met2, met3)


# Graph 3
png(file = "plot3.png", width=480,height=480) # launch png device
with(consumo, plot(met1, xaxt="n", type="l", ylab= "Global Active Power (kilowatts)",
                   xlab=""))
lines(consumo$met2, col="red")
lines(consumo$met3, col="blue")
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))
legend("topright", legend= c("Sub_metering_1", "Sub_,metering_2", "Sub_,metering_3"),
       col=c("black", "blue", "red"), pch = "-")
dev.off() # close device


# Save the graph
