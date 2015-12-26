

baltimore <- subset(SCC, fips=="24510")
agg2_baltimore <- aggregate(baltimore$Emissions, by=list(source=baltimore$type,year=baltimore$year), FUN=sum)
print(qplot(year, x,  data=agg2_baltimore,  col=source,main="Emission by Source in Baltimore", ylab="Emissions") + geom_smooth())
#ggsave('plot3.png',p1,height=4,width=6)
#dev.off()
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()
