normalize_em <- function(x) { max_em = max(x$x);
                              min_em = min(x$x);
                              year = x$year;
			      city = x$city;
				norm_x = (x$x - min_em)/(max_em - min_em)
                               return ( data.frame(city,year, norm_x)) 
}

baltimore <- subset(SCC, fips=="24510" )
LA <- subset(SCC,  fips == "06037")
ic_emissions <- subset(NEI, SCC.Level.One=="Mobile Sources")

ic_emissions_baltimore <- merge(ic_emissions, baltimore, by.x = "SCC" )
filter_ic_emissions_baltimore <- subset(ic_emissions_baltimore, grepl("highway", SCC.Level.Two, ignore.case = TRUE) )
agg_emissions_baltimore <- aggregate(filter_ic_emissions_baltimore$Emissions, by= list( city = filter_ic_emissions_baltimore$fips, year= filter_ic_emissions_baltimore$year), FUN=sum)
norm_emissions_baltimore <- normalize_em(agg_emissions_baltimore)
norm_emissions_baltimore$city <- "Baltimore"

ic_emissions_LA <- merge(ic_emissions, LA, by.x = "SCC" )
filter_ic_emissions_LA <- subset(ic_emissions_LA, grepl("highway", SCC.Level.Two, ignore.case = TRUE) )
agg_emissions_LA <- aggregate(filter_ic_emissions_LA$Emissions, by= list( city = filter_ic_emissions_LA$fips,year= filter_ic_emissions_LA$year), FUN=sum)
norm_emissions_LA <- normalize_em(agg_emissions_LA)
norm_emissions_LA$city <- "Los Angeles"

comb_emissions <- rbind(norm_emissions_baltimore, norm_emissions_LA)
print(qplot(year,norm_x, data=comb_emissions, col=city, ylab = "Normalized Emissions", main= "Motor Vehicle Pollution") +  geom_smooth())

dev.copy(png,'plot6.png',width=680,height=480)
dev.off()






