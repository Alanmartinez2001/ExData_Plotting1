library(data.table)
library(dplyr)



# Load the data
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "consumo.zip", method = "curl")
unzip("consumo.zip", exdir = "consumo")



# Keep only the data from 01/feb/2007 and 02/feb/2007 and the vars that we will need
consumo<-fread("consumo/household_power_consumption.txt", sep = ";", 
               header = TRUE, stringsAsFactors = FALSE)[Date %in% c("1/2/2007", "2/2/2007")]
consumo <-as.data.frame(sapply(consumo[,3:9], as.numeric))
consumo <- consumo %>%
    mutate(gpa=as.numeric(Global_active_power),
           volt=as.numeric(Voltage),
           met1=as.numeric(Sub_metering_1),
           met2=as.numeric(Sub_metering_2),
           met3=as.numeric(Sub_metering_3),
           grp=as.numeric(Global_reactive_power))


png(file = "plot4.png", width=480,height=480) # launch png device

# Set the number of rows of the aggregate graph
par(mfrow=c(2,2))

# 1,1 ---
with(consumo, plot(gpa, xaxt="n", type="l", ylab= "Global Active Power (kilowatts)",
                    xlab=""))
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))


# 1,2 ---
with(consumo, plot(volt, xaxt="n", type="l", ylab= "Voltage",
                    xlab="Time"))
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))


# 2,1 ---
with(consumo, plot(met1, xaxt="n", type="l", ylab= "Global Active Power (kilowatts)",
                    xlab=""))
lines(consumo$met2, col="red") ; lines(consumo$met3, col="blue")
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))
legend("topright", legend= c("Sub_metering_1", "Sub_,metering_2", "Sub_,metering_3"),
       col=c("black", "blue", "red"), pch = "-")


# 2,2 ---
with(consumo, plot(grp, xaxt="n", type="l", ylab= "Global Reactive Power",
                    xlab="Time"))
axis(1, labels = c("Thursday", "Friday", "Saturday"), at = c(0,1440,2880))

#
dev.off() # close device
