library(ggplot2)

coal <- grep("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = T)
coal <- union(coal, grep("Coal", SCC$SCC.Level.Four, ignore.case = T))
coal <- union(coal, grep("Coal", SCC$SCC.Level.Three, ignore.case = T))
coal <- setdiff(coal, grep("Storage and Transfer", SCC$EI.Sector, ignore.case = T))
coal <- setdiff(coal, grep("Mining", SCC$EI.Sector, ignore.case = T))
coal.SCC <- unique(SCC[coal, "SCC"])
coal.NEI <- NEI[NEI$SCC %in% coal.SCC,]

p <- ggplot(coal.NEI, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  labs(x = "Year") +
  labs(y = expression("PM"[2.5] * " (ton)")) +
  labs(title = expression("PM"[2.5] * " emissions related to coal combustion"))
print(p)
