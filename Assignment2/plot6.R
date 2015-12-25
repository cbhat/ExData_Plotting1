

baltimore_max <- max(subset(SCC, fips=="24510" )$Emissions)
LA_max <- max(subset(SCC, fips=="06037" )$Emissions)
baltimore_LA <- subset(SCC, fips=="24510" | fips == "06037")
norm_baltimore_LA <- normalize_em(baltimore_LA)
ic_emissions <- subset(NEI, SCC.Level.One=="Mobile Sources")
ic_emissions_baltimore_LA <- merge(ic_emissions, norm_baltimore_LA, by.x = "SCC" )
filter_ic_emissions_baltimore_LA <- subset(ic_emissions_baltimore_LA, grepl("highway", SCC.Level.Two, ignore.case = TRUE) | grepl("ng", SCC.Level.Two, ignore.case = TRUE) | grepl("lp", SCC.Level.Two, ignore.case = TRUE))
agg_ic_emissions_baltimore_LA <- aggregate(filter_ic_emissions_baltimore_LA$Emissions, by = list(year= filter_ic_emissions_baltimore_LA$year, city=filter_ic_emissions_baltimore_LA$fips), FUN=sum)
agg_ic_emissions_baltimore_LA$city [agg_ic_emissions_baltimore_LA$city == "24510"] <- "Baltimore"
agg_ic_emissions_baltimore_LA$city [agg_ic_emissions_baltimore_LA$city == "06037"] <- "Los Angeles"
qplot(year,x, data=agg_ic_emissions_baltimore_LA, col=city, ylab = "Emissions", main= "Motor Vehicle Pollution") + geom_smooth()


normalize_em = function(x){ fips = x$fips;
                            SCC = x$SCC;
                            Pollutant = x$Pollutant;
                            type = x$type;
                            year= x$year;
                            Emissions = 0;
                            if ( x$fips == "06037"){ Emissions = x$Emissions/LA_max;  print (Emissions)} else { Emissions = x$Emissions/baltimore_max;}
                            return ( data.frame( fips, SCC, Pollutant, Emissions, type, year))

