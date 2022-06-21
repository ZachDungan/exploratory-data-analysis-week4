setwd("~/R/exploratory-data-analysis-week4")

library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter SCC
scc_coal_comb <- SCC %>%
  filter(grepl('Coal', EI.Sector))

# Subset NEI
nei_coal_sub <- subset(NEI, NEI$SCC %in% scc_coal_comb$SCC)

# Merge
nei_coal <- merge(x = nei_coal_sub, 
                  y = SCC, 
                  by.x = "SCC",
                  by.y = "SCC")

tot_nei_coal <- aggregate(nei_coal$Emissions, list(nei_coal$year), FUN = sum)

png(filename = "plot4.png", width = 480, height = 480)

ggplot(data = tot_nei_coal, aes(Group.1, x)) + 
  geom_point(col = "black") +
  xlab("Year") + 
  ylab("Total Emissions") + 
  ggtitle("Total Coal Emissions (US)")

dev.off()

## Answer: Yes, coal emissions have decreased since 1999