# plot4.R

#setwd("Exploratory Analisis/")

file_path <- "household_power_consumption.txt"
header <- read.table(file_path, sep = ";", nrows = 1, header = F)
powerConsumption <- read.table(file_path, sep = ";", nrows = (60*24*2), 
                               skip = 66636, header = T, na.strings = "?")

colnames(powerConsumption) <- unlist(header)

datetime <- strptime(paste(powerConsumption$Date, powerConsumption$Time), 
                     format = "%d/%m/%Y %H:%M:%S")

powerConsumption$datetime <- datetime

{
png("Project1/plot4.png")
par(mfrow = c(2,2), mar = c(3,4,2,2))

with(powerConsumption, {
        plot(datetime, Global_active_power, xlab = "", 
             ylab = "Global Active Power", type = "l")
        plot(datetime, Voltage, type = "l")
        plot(datetime, Sub_metering_1, type = "l", xlab = "", 
             ylab = "Energy sub metering")
        lines(datetime, Sub_metering_2, col = 2)
        lines(datetime, Sub_metering_3, col = 4)
        legend("topright", col = c(1,2,4), lty = 1,
               legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
               )
        plot(datetime, Global_reactive_power, type = "l")
})
dev.off()
}