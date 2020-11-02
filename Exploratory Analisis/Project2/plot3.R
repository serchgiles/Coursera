# plot3.R

library(ggplot2)

setwd("Exploratory Analisis/Project2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

NEI[]
p <- ggplot(NEI, aes(x=year, y=Emissions, fill=type))
p + geom_bar(stat = "sum") + facet_grid(.~type)
