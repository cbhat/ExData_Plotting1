powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

subpowerdata = subset(powerdata, Date =='1/2/2007' | Date == '2/2/2007')

sample4data <- subpowerdata[,c(1,2,4,5)]


xt4 <- as.POSIXct(strptime(paste(sample4data$Date,sample4data$Time),"%d/%m/%Y %H:%M:%S"))
volt <- as.numeric(as.character(sample4data$Voltage))
rpower <- as.numeric(as.character(sample4data$Global_reactive_power))

par(mfrow = c(2,2), oma=c(0,0,0,0))
plot(yt ~ xt, type ="l", ylab = "Global Active Power (kilowatts)", xlab=" ")

plot(volt ~ xt4, type ="l", ylab = "Voltage",xlab = "datetime", ylim=range(230:250 ))

plot(ymtg1 ~ xt3, type ="l", ylab = "Energy sub Metering", xlab = " ")
lines(ymtg3 ~ xt3, col="red")
lines(ymtg2 ~ xt3, col="blue")
legend("topright", pch = '-', legend= c("sub metering 1", "sub metering 2","sub metering 3"), col=c("black","blue","red"),cex= 0.75)

plot(rpower ~ xt4, type ="l", ylab = "Global Reactive Power",xlab = "datetime",ylim=range(0:1))
dev.copy(png,'plot4.png',width=480,height=480)
dev.off()

