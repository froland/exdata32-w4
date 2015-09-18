df <- NEI %>%
  select(Emissions, year) %>%
  mutate(year = factor(year, levels = c(1999, 2002, 2005, 2008), ordered = T)) %>%
  group_by(year) %>%
  summarise(total.emissions = sum(Emissions))

plot(df$year, df$total.emissions,
     ylab = "PM2.5 (tons)", main = "Total PM2.5 emissions by year")
