library(ggplot2)

# Get the sum of Emissions in Baltimore
balt <- NEI[NEI$fips == 24510,]
balt$type <- factor(tolower(balt$type), c("point", "nonpoint", "on-road", "non-road"))

p <- ggplot(balt, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity", aes(fill = type)) +
  facet_grid(. ~ type) +
  labs(x = "Year") +
  labs(y = expression("PM"[2.5]*" (ton)")) +
  labs(title = expression("PM"[2.5] * " emissions in Baltimore")) +
  theme(legend.position="none")
print(p)
