# plot5.R

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicleBalti <- subset(NEI, type == "ON-ROAD" & fips == 24510)

coul <- RColorBrewer::brewer.pal(4, "Set3") 

par(mfrow=c(1,1))
barplot(with(vehicleBalti, tapply(Emissions, year, sum)), col = coul)
title(main = "Total Emission of PM2.5 from\nmotor-vehicle sources in Baltimore", 
      xlab = "Year", y = "Emission")
