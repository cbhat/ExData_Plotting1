
ic_emissions <- subset(NEI, SCC.Level.One=="Mobile Sources")
#ic_emissions_baltimore <- merge(ic_emissions, baltimore, by.x = ic_emissions.SCC by.y = balimore.SCC)
ic_emissions_baltimore <- merge(ic_emissions, baltimore, by.x = "SCC" )
agg_ic_emissions_baltimore <- aggregate(ic_emissions_baltimore$Emissions, by = list(year= ic_emissions_baltimore$year, category=ic_emissions_baltimore$SCC.Level.Two), FUN=sum)



#Assume that the motor vehicles include Highway and non Highway vehicles, Aircraft, marine vessels and Pleasure craft.
#Remove paved roads, unpaved roads and Railroad equipment.

#filter_ic_emissions_baltimore <- subset(agg_ic_emissions_baltimore, grepl("highway", category, ignore.case = TRUE) | grepl("ng", category, ignore.case = TRUE) | grepl("lp", category, ignore.case = TRUE))
filter_ic_emissions_baltimore <- subset(agg_ic_emissions_baltimore, grepl("highway", category, ignore.case = TRUE) )
print(qplot(year,x, data=filter_ic_emissions_baltimore, col=category,ylab="Emissions", main="Motor Vehicle emissions in Baltimore from 1999 to 2008") + geom_smooth())
dev.copy(png,'plot5.png',width=680,height=480)
dev.off()
