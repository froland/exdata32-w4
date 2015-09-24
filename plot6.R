# Download zip file from Internet and read content into two variables: NEI and
# SCC.

kZipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
kZipFilename <- "exdata-data-NEI_data.zip"
kNeiFilename <- "summarySCC_PM25.rds"
kSccFilename <- "Source_Classification_Code.rds"

DownloadZipIfNeeded <- function() {
  if (!file.exists(kZipFilename)) {
    download.file(kZipUrl, kZipFilename, mode = "wb")
  }
}

ExtractZipIfNeeded <- function() {
  if (!file.exists(kNeiFilename) || !file.exists(kSccFilename)) {
    unzip(zipfile = kZipFilename)
  }
}

DownloadZipIfNeeded()
ExtractZipIfNeeded()
NEI <- readRDS(kNeiFilename)
SCC <- readRDS(kSccFilename)
NEI <- unique(NEI)

png("plot6.png")

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

dev.off()
