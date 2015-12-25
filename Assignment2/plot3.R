

baltimore <- subset(SCC, fips=="24510")
agg2_baltimore <- aggregate(baltimore$Emissions, by=list(source=baltimore$type,year=baltimore$year), FUN=sum)
p1<- qplot(year, x,  data=agg2_baltimore,  col=source,main="Emission by Source in Baltimore", ylab="Emissions") + geom_smooth()
p1
ggsave('plot3.png',p1)
dev.off()
