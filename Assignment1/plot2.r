powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")


subpowerdata = subset(powerdata, Date =='1/2/2007' | Date == '2/2/2007')

sample2data <- subpowerdata[,c(1,2,3)]


xt <- as.POSIXct(strptime(paste(sample2data$Date,sample2data$Time),"%d/%m/%Y %H:%M:%S"))
yt <- as.numeric(as.character(sample2data$Global_active_power))
class(xt) <- c('POSIXt','POSIXct')

plot(yt ~ xt, type ="l", ylab = "Global Active Power (kilowatts)", xlab=" ")

dev.copy(png,'plot2.png',width=480,height=480)
dev.off()
