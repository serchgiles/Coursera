# plot2.R

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
png("Project1/plot2.png")
par(mfrow = c(1,1))
with(powerConsumption,
     plot(datetime, Global_active_power, type = "l", xlab = "", 
          ylab = "Global Active Powe (kilowatts)")
)
dev.off()
}