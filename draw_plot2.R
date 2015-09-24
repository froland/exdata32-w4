# Get the sum of Emissions in Baltimore
balt <- NEI[NEI$fips == 24510,]
# Groups them by year and computes the total
baltsum <- tapply(balt$Emissions, balt$year, sum)

barplot(baltsum,
        xlab = "Year",
        ylab = expression("PM"[2.5]*" (ton)"),
        main = expression("Sum of PM"[2.5] * " emissions in Baltimore City"))
