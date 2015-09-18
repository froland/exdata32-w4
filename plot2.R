library(dplyr)

kZipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
kZipFilename <- "exdata-data-NEI_data.zip"
kNeiFilename <- "summarySCC_PM25.rds"

DownloadZipIfNeeded <- function() {
  if (!file.exists(kZipFilename)) {
    download.file(kZipUrl, kZipFilename, mode = "w")
  }
}

ExtractZipIfNeeded <- function() {
  if (!file.exists(kNeiFilename)) {
    unzip(zipfile = kZipFilename)
  }
}

DownloadZipIfNeeded()
ExtractZipIfNeeded()
NEI <- readRDS(kNeiFilename)

df <- NEI %>%
  filter(fips == "24510") %>%
  select(Emissions, year) %>%
  mutate(year = factor(year, levels = c(1999, 2002, 2005, 2008), ordered = T)) %>%
  group_by(year) %>%
  summarise(total.emissions = sum(Emissions))

png("plot2.png")

plot(df$year, df$total.emissions,
     ylab = "PM2.5 (tons)")
title(main = "PM2.5 emissions by year in\nBaltimore City, Maryland", cex.main = 0.9)

dev.off()
