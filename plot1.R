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

png("plot1.png")

# Get the sum of Emissions grouped by year
pmsum <- tapply(NEI$Emissions, NEI$year, sum)

barplot(pmsum,
        xlab = "Year",
        ylab = expression("PM"[2.5]*" (ton)"),
        main = expression("Sum of PM"[2.5] * " emissions"))

dev.off()
