powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

subpowerdata = subset(powerdata, Date =='1/2/2007' | Date == '2/2/2007')

sample3data <- subpowerdata[,c(1,2,7,8,9)]


xt3 <- as.POSIXct(strptime(paste(sample3data$Date,sample3data$Time),"%d/%m/%Y %H:%M:%S"))
ymtg1 <- as.numeric(as.character(sample3data$Sub_metering_1))
ymtg2 <- as.numeric(as.character(sample3data$Sub_metering_2))
ymtg3 <- as.numeric(as.character(sample3data$Sub_metering_3))
class(xt) <- c('POSIXt','POSIXct')

plot(ymtg1 ~ xt3, type ="l", ylab = "Energy sub Metering", xlab = " ")
lines(ymtg3 ~ xt3, col="red")
lines(ymtg2 ~ xt3, col="blue")
legend("topright", pch = '-', legend= c("sub metering 1", "sub metering 2","sub metering 3"), col=c("black","blue","red"),cex= 0.75)

dev.copy(png,'plot3.png',width=480,height=480)
dev.off()

