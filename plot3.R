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

png("plot3.png")

library(ggplot2)

# Get the sum of Emissions in Baltimore
balt <- NEI[NEI$fips == 24510,]
balt$type <- factor(tolower(balt$type), c("point", "nonpoint", "on-road", "non-road"))

p <- ggplot(balt, aes(as.factor(year), Emissions)) +
  geom_bar(stat = "identity", aes(fill = type)) +
  facet_grid(. ~ type) +
  labs(x = "Year") +
  labs(y = expression("PM"[2.5]*" (ton)")) +
  labs(title = expression("PM"[2.5] * " emissions in Baltimore City")) +
  theme(legend.position="none")
print(p)

dev.off()
