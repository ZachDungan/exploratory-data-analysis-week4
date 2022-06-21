setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 3

BC <- subset(NEI, fips == "24510")
tot_BC_type <- aggregate(BC$Emissions, list(BC$year, BC$type), FUN = sum)

png(filename = "plot3.png", width = 480, height = 480)

ggplot(data = tot_BC_type, aes(Group.1, x)) + 
  geom_point(col = "black") +
  facet_grid(. ~ Group.2) + 
  xlab("Year") + 
  ylab("Total Emissions") + 
  ggtitle("Totel Emissions by Type in Baltimore City")

dev.off()

## Answer: Non-road, Non-point, and On-Road have all decreased in the time frame