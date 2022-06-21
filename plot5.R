setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter SCC
scc_vehicle <- SCC %>%
  filter(grepl('Veh', Short.Name))

# Subset NEI
nei_BC_veh <- subset(NEI, fips == "24510" & NEI$SCC %in% scc_vehicle$SCC)

# Merge fields
nei_merge <- merge(x = nei_BC_veh, 
                    y = SCC, 
                    by.x = "SCC",
                    by.y = "SCC")

tot_BC_veh <- aggregate(nei_merge$Emissions, list(nei_merge$year), FUN = sum)

png(filename = "plot5.png", width = 480, height = 480)

ggplot(data = tot_BC_veh, aes(Group.1, x)) + 
  geom_point(col = "black") +
  xlab("Year") + 
  ylab("Total Emissions") + 
  ggtitle("Total Vehicle Emissions in Baltimore City")

dev.off()

## Answer: Emissions have decreased from motor vehicles in Baltimore City since 1999