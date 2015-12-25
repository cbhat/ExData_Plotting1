

powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

subpowerdata = subset(powerdata, Date =='1/2/2007' | Date == '2/2/2007')

sample1data <- subpowerdata[,c(3)]

hist(as.numeric(as.character(sample1data)), main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")

dev.copy(png,'plot1.png',width=480,height=480)
dev.off()

