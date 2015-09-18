# Eploratory Data Analysis - week 4 assignment

## Data

The data for this assignment are available from the course web site as a single 
zip file:

[Data for Peer Assessment][1] [29Mb]

The zip file contains two files:

PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with
all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year,
the table contains number of tons of PM2.5 emitted from a specific type of
source for the entire year.

Source Classification Code Table (Source_Classification_Code.rds): This table
provides a mapping from the SCC digit strings in the Emissions table to the
actual name of the PM2.5 source. The sources are categorized in a few different
ways from more general to more specific and you may choose to explore whatever
categories you think are most useful.

```
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Questions

**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**

Using the base plotting system, make a plot showing the total PM2.5
emission from all sources for each of the years 1999, 2002, 2005, and 2008.

![Total PM2.5 emissions by year](plot1.png)

```
df <- NEI %>%
  select(Emissions, year) %>%
  mutate(year = factor(year, levels = c(1999, 2002, 2005, 2008), ordered = T)) %>%
  group_by(year) %>%
  summarise(total.emissions = sum(Emissions))

plot(df$year, df$total.emissions,
     ylab = "PM2.5 (tons)", main = "Total PM2.5 emissions by year")

```

**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?**

Use the base plotting system to make a plot answering this question.

**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?**

Use the ggplot2 plotting system to make a plot answer this question.

**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**

**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**

**Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?**

[1]: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip "National Emissions Inventory"
