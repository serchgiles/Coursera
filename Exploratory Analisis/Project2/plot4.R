# plot4.R

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

fuelCoal_logical <- grepl("Fuel Comb", SCC$EI.Sector) & grepl("Coal", SCC$EI.Sector)

fuelCoal <- SCC[fuelCoal_logical,c("SCC", "EI.Sector")]

subNEI <- NEI[NEI$SCC %in% fuelCoal$SCC, ]

coul <- RColorBrewer::brewer.pal(4, "Set2") 

barplot(with(subNEI, tapply(Emissions, year, sum)), col = coul)
title(main = "Total Emission of PM2.5 from \nCoal combustion related sources", 
      xlab = "Year", y = "Emission")
