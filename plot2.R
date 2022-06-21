setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 2

BC <- subset(NEI, fips == "24510")
tot_BC <- aggregate(BC$Emissions, list(BC$year), FUN = sum)

png(filename = "plot2.png", width = 480, height = 480)

plot(tot_BC, 
     xlab = "Year", 
     ylab = "Total Emissions in Baltimore City", 
     col = "red")

dev.off()

## Answer: Yes, overall emissions have decreased, but they did spike in 2005