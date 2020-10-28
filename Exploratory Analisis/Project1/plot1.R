# plot1.R

#setwd("Exploratory Analisis/")

file_path <- "household_power_consumption.txt"
header <- read.table(file_path, sep = ";", nrows = 1, header = F)
powerConsumption <- read.table(file_path, sep = ";", nrows = (60*24*2), 
                               skip = 66636, header = T, na.strings = "?")
colnames(powerConsumption) <- unlist(header)

{
png("Project1/plot1.png")
par(mfrow = c(1,1))

with(powerConsumption, 
     hist(Global_active_power, main = "Global Active Power", col = "red",
          xlab = "Global Active Power (kilowatts)"))
dev.off()
}
