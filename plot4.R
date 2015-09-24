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

png("plot4.png")

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

dev.off()
