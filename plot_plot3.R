library(ggplot2)

sources.df <- SCC %>%
  select(SCC, Data.Category) %>%
  mutate(Data.Category = factor(Data.Category,
                                levels = c("Point", "Nonpoint", "Onroad", "Nonroad")))

df <- NEI %>%
  filter(fips == "24510") %>%
  select(Emissions, year, SCC) %>%
  mutate(year = factor(year, levels = c(1999, 2002, 2005, 2008), ordered = T),
         SCC = factor(SCC, levels = levels(sources.df$SCC))) %>%
  inner_join(sources.df, by = "SCC") %>%
  filter(Data.Category %in% c("Point", "Nonpoint", "Onroad", "Nonroad")) %>%
  group_by(Data.Category, year) %>%
  summarise(Emissions = median(Emissions))

p <- ggplot(df, aes(year, Emissions))
p <- p + geom_point()
p <- p + geom_smooth(method = "lm", aes(group = 1))
p <- p + facet_wrap(~Data.Category, ncol = 2, scales = "free_y")
p <- p + xlab("")
p <- p + ylab(expression(paste(PM["2.5"], " emissions (ton)", sep = "")))
p <- p + ggtitle(expression(paste(PM["2.5"], " emissions in Baltimore City, Maryland", sep = "")))

print(p)
