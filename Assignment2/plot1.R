


#SCC <- readRDS("summarySCC_PM25.rds")
#NEI <- readRDS("Source_Classification_Code.rds")

pollutant <- aggregate(SCC$Emissions, by=list(year = SCC$year), FUN=sum)

plot( x ~ year , data=pollutant, type= "h", lwd=8,col="red", main= "Total PM2.5 emisssions - all sources", ylab= "Emissions ( in tons )", xaxs="r")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()
