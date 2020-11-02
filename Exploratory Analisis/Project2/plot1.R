# plot1.R

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

{
png("plot1.png")
barplot(with(NEI, tapply(Emissions, year, sum)))
title(main = "Total Emission of PM2.5 in all the country per year", 
      xlab = "Year", y = "Emission")
dev.off()
}

