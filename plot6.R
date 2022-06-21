setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Filter SCC
scc_vehicle <- SCC %>%
  filter(grepl('Veh', Short.Name))

# Baltimore City
# Subset NEI
nei_BC_veh <- subset(NEI, fips == "24510" & NEI$SCC %in% scc_vehicle$SCC)

# Merge fields
nei_merge <- merge(x = nei_BC_veh, 
                   y = SCC, 
                   by.x = "SCC",
                   by.y = "SCC")

tot_BC_veh <- aggregate(nei_merge$Emissions, list(nei_merge$year), FUN = sum)

# Los Angeles
# Subset NEI
nei_LA_veh <- subset(NEI, fips == "06037" & NEI$SCC %in% scc_vehicle$SCC)

# Merge fields
nei_merge_LA <- merge(x = nei_LA_veh, 
                   y = SCC, 
                   by.x = "SCC",
                   by.y = "SCC")

tot_LA_veh <- aggregate(nei_merge_LA$Emissions, list(nei_merge_LA$year), FUN = sum)

tot_BC_veh_2 <- cbind(tot_BC_veh, "City" = rep("Baltimore", 4))
tot_LA_veh_2 <- cbind(tot_LA_veh, "City" = rep("Los Angeles", 4))

tot_comparison <- rbind(tot_BC_veh_2, tot_LA_veh_2)

png(filename = "plot6.png", width = 480, height = 480)

ggplot(data = tot_comparison, aes(Group.1, x, col = City)) + 
  geom_point(size = 2) +
  xlab("Year") + 
  ylab("Total Emissions") + 
  ggtitle("Comparison of Vehicle Emissions in Baltimore City and Los Angeles")

dev.off()

## Answer: Baltimore City experienced the greater change in emissions overtime, as seen in the graph
