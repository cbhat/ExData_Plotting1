
coal <- subset(NEI, grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Short.Name, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", EI.Sector, ignore.case = TRUE)| grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.One, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Two, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Three, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Four, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Option.Group, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Option.Set, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Usage.Notes, ignore.case = TRUE))


merge_SCC <- merge( SCC, coal, SCC.SCC=coal.SCC)

combustion <- subset( merge_SCC, grepl("Combustion", SCC.Level.One, ignore.case=TRUE))
 agg_combustion <- aggregate(combustion$Emissions,  by = list(year= combustion$year, category=combustion$SCC.Level.Two), FUN=sum)
print(qplot(year ,y=x, data=agg_combustion,  col=category, ylab="Emissions ", main="Coal Usage across different Categories" )+ geom_line() ) 
dev.copy(png,'plot4.png',width=680,height=480)
dev.off()
