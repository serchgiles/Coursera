# plot2.R

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

{
png("plot2.png")
    
barplot(with(subset(NEI, fips == "24510"), tapply(Emissions, year, sum)))
title(main = "Total Emission of PM2.5 in Baltimore per year", 
      xlab = "Year", y = "Emission")

dev.off()
}
