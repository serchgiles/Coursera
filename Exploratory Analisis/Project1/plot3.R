# plot3.R

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
png("Project1/plot3.png")
par(mfrow = c(1,1))

with(powerConsumption, {
     plot(datetime, Sub_metering_1, type = "l", xlab = "", 
          ylab = "Energy sub metering")
     lines(datetime, Sub_metering_2, col = 2)
     lines(datetime, Sub_metering_3, col = 4)
     legend(x = "topright", col = c(1,2,4), lty = 1,
            legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
     }
)

dev.off()
}
