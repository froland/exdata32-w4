library(ggplot2)

coal.scc <- as.character(SCC[grep("coal", tolower(SCC$Short.Name)), "SCC"])
coal <- NEI[NEI$SCC %in% coal.scc,]

p <- ggplot(coal, aes(as.factor(year), log10(Emissions))) +
  geom_boxplot() +
  labs(x = "Year") +
  labs(y = expression("log"[10] * "(PM"[2.5] * ") (ton)")) +
  labs(title = expression("PM"[2.5] * " emissions related to coal combustion"))
print(p)

p <- ggplot(coal, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity") +
  labs(x = "Year") +
  labs(y = expression("PM"[2.5] * " (ton)")) +
  labs(title = expression("PM"[2.5] * " emissions related to coal combustion"))
print(p)
