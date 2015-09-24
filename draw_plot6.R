library(ggplot2)

motor.NEI <- NEI[NEI$type %in% c("ON-ROAD", "NON-ROAD"),]
baltimore <- motor.NEI[motor.NEI$fips == "24510",]
baltimore$city <- "Baltimore City"
losangeles <- motor.NEI[motor.NEI$fips == "06037",]
losangeles$city <- "Los Angeles"
both <- rbind(baltimore, losangeles)
both$city <- factor(both$city, levels = c("Baltimore City", "Los Angeles"))

p <- ggplot(both, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity", aes(fill = city)) +
  labs(x = "Year") +
  labs(y = expression("PM"[2.5] * " (ton)")) +
  facet_grid(. ~ city) +
  labs(title = expression("Motor vehicle PM"[2.5] * " emissions")) +
  theme(legend.position="none")
print(p)
