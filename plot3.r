powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

sub1powerdata <- subset(powerdata, Date =='1/2/2007')
sub2powerdata <- subset(powerdata, Date =='2/2/2007')

subpowerdata <- merge(x = sub1powerdata, y = sub2powerdata, by = "Date", all = TRUE)


sample3data <- subpowerdata[,c(1,2,7,8,9,15,16,17)]

replacenull <- function(x) {
        if ( is.na(as.numeric(as.character(x))) ) return( 0)
        return(as.numeric(as.character(x)))
}

gendate <- function(x,y){
   if ( is.na(as.character(y)) ) return( paste (x, "00:00:00"))
   return( paste(x,y))

}


cleantime3 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]
    g <- x[c(7)]
    h <- x[c(8)]
    mydate <- gendate(a,b)
    mydate <- as.POSIXct(strptime(mydate, "%d/%m/%Y %H:%M:%S"))

    return ( mydate)
}

cleanmtg1 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]
    g <- x[c(7)]
    h <- x[c(8)]
    submeeting1 <- replacenull(c) + replacenull(f)
    submeeting1 <- as.numeric(as.character(submeeting1))

    return (  submeeting1)
}

cleanmtg2 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]
    g <- x[c(7)]
    h <- x[c(8)]

    submeeting2 <- replacenull(d) + replacenull(g)
    submeeting2 <- as.numeric(as.character(submeeting2))

    return (  submeeting2)
}

cleanmtg3 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    e <- x[c(5)]
    f <- x[c(6)]
    g <- x[c(7)]
    h <- x[c(8)]

    submeeting3 <- replacenull(e) + replacenull(h)
    submeeting3 <- as.numeric(as.character(submeeting3))
    return (  submeeting3)
}


xt3 <- apply(sample3data, 1, cleantime3) 
ymtg1 <- apply(sample3data, 1, cleanmtg1)
ymtg2 <- apply(sample3data, 1, cleanmtg2)
ymtg3 <- apply(sample3data, 1, cleanmtg3)

class(xt3) <- c('POSIXt','POSIXct')

plot(ymtg1 ~ xt3, type ="l",xaxt="n", ylab = "Energy sub Metering")
lines(ymtg3 ~ xt3, col="red")
lines(ymtg2 ~ xt3, col="blue")
legend("topright", pch = '-', legend= c("sub metering 1", "sub metering 2","sub metering 3"), col=c("black","blue","red"),cex= 0.75)
axis.POSIXct(1, at = xt, format = "%H\n%a")
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()


