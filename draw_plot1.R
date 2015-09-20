# Get the sum of Emissions grouped by year
pmsum <- tapply(NEI$Emissions, NEI$year, sum)

barplot(pmsum,
        xlab = "Year",
        ylab = expression("PM"[2.5]*" (ton)"),
        main = expression("Sum of PM"[2.5] * " emissions"))
