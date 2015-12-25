

baltimore <- subset(SCC, fips=="24510")
agg_baltimore <- aggregate(baltimore$Emissions, by=list(year=baltimore$year), FUN=sum)

plot( x ~ year , data=agg_baltimore, type= "l",col="red", main= "Total PM2.5 emisssions in Baltimore", ylab= "Emissions ")
usr <- par( "usr" )
text(usr[1]+100,usr[3]+50,"Emission in Baltimore decreased from 1999 to 2008")
dev.copy(png,'plot2.png',width=480,height=480)
dev.off()
