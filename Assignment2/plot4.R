
coal <- subset(NEI, grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Short.Name, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", EI.Sector, ignore.case = TRUE)| grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.One, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Two, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Three, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", SCC.Level.Four, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Option.Group, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Option.Set, ignore.case = TRUE) | grepl("Coal|anthracite|charcoal|lignite|peat|bituminous", Usage.Notes, ignore.case = TRUE))


merge_SCC <- merge( SCC, coal, SCC.SCC=coal.SCC)

combustion <- subset( merge_SCC, grepl("Combustion", SCC.Level.One, ignore.case=TRUE))
 agg_combustion <- aggregate(combustion$Emissions,  by = list(year= combustion$year,category1=combustion$SCC.Level.One, category2=combustion$SCC.Level.Two), FUN=sum)
p4 <- qplot(year ,x, data=agg_combustion, facets=.~category1, col=category2, ylab="Emissions ", main="Coal Usage across different Segments") + geom_smooth()
p4
ggsave('plot4.png',height=5, width=8,p4)
dev.off()
