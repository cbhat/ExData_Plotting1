

powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

sub1powerdata <- subset(powerdata, Date =='1/2/2007')
sub2powerdata <- subset(powerdata, Date =='2/2/2007')

subpowerdata <- merge(x = sub1powerdata, y = sub2powerdata, by = "Date", all = TRUE)

replacenull <- function(x) {
	if ( is.na(as.numeric(as.character(x))) ) return( 0)
        return(as.numeric(as.character(x)))
}

activepowerdata <- subpowerdata[,c(3,11)]

pdata1 <- apply ( activepowerdata, c(1,2), replacenull)
pdata2 <- pdata1[,1]+ pdata1[,2]

hist(pdata2, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()

