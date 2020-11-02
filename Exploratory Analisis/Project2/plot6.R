# plot5.R

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehicleBalti <- subset(NEI, type == "ON-ROAD" & fips == "24510")
vehicleAngel <- subset(NEI, type == "ON-ROAD" & fips == "06037")


coul <- RColorBrewer::brewer.pal(4, "Set3") 

tabBalti <- with(vehicleBalti, tapply(Emissions, year, sum))
tabAngel <- with(vehicleAngel, tapply(Emissions, year, sum))


par(mfrow = c(2,1))
barplot(tabBalti, col = coul)
title(main = "PM2.5 from motor-\nvehicle sources", 
      xlab = "Year", y = "Emission", sub = "Baltimore City")

barplot(tabAngel, col = coul)
title(main = "PM2.5 from motor-\nvehicle sources", 
      xlab = "Year", y = "Emission", sub = "Los Angeles County")
