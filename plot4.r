powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

sub1powerdata <- subset(powerdata, Date =='1/2/2007')
sub2powerdata <- subset(powerdata, Date =='2/2/2007')

subpowerdata <- merge(x = sub1powerdata, y = sub2powerdata, by = "Date", all = TRUE)


sample4data <- subpowerdata[,c(1,2,4,5,12,13)]

replacenull <- function(x) {
        if ( is.na(as.numeric(as.character(x))) ) return( 0)
        return(as.numeric(as.character(x)))
}

gendate <- function(x,y){
   if ( is.na(as.character(y)) ) return( paste (x, "00:00:00"))
   return( paste(x,y))

}


cleantime4 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]

    mydate <- gendate(a,b)
    mydate <- as.POSIXct(strptime(mydate, "%d/%m/%Y %H:%M:%S"))

    return ( mydate)
}

cleanvolt <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]

    volt <- replacenull(d) + replacenull(f)
    volt <- as.numeric(as.character(volt))

    return (  volt)
}

cleanrpower <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]

    rpower <- replacenull(c) + replacenull(e)
    rpower <- as.numeric(as.character(rpower))

    return (  rpower)
}



xt4 <- apply(sample4data, 1, cleantime4) 
volt <- apply(sample4data, 1, cleanvolt)
rpower <- apply(sample4data, 1, cleanrpower)

class(xt4) <- c('POSIXt','POSIXct')

par(mfrow = c(2,2), oma=c(0,0,0,0))
plot(yt ~ xt, type ="l", ylab = "Global Active Power (kilowatts)")
plot(volt ~ xt4, type ="l", ylab = "Voltage",xlab = "datetime", ylim=range(230:250 ))
plot(ymtg1 ~ xt3, type ="l", ylab = "Energy sub Metering")
lines(ymtg3 ~ xt3, col="red")
lines(ymtg2 ~ xt3, col="blue")
legend("topright", pch = '-', legend= c("sub metering 1", "sub metering 2","sub metering 3"), col=c("black","blue","red"),cex= 0.25,pt.cex=1, xjust=0.5,yjust=0.5)
plot(rpower ~ xt4, type ="l", ylab = "Global Reactive Power",xlab = "datetime",ylim=range(0:1))
dev.copy(png,'plot4.png',width=480,height=480)
dev.off()


