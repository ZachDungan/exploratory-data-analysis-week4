setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 1

total_emissions <- aggregate(NEI$Emissions, list(NEI$year), FUN = sum)

png(filename = "plot1.png", width = 480, height = 480)

plot(total_emissions, 
     xlab = "Year", 
     ylab = "Total Emissions", 
     col = "blue")

dev.off()

## Answer: Yes, total emissions have decreased