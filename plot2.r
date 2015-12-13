powerdata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")

sub1powerdata <- subset(powerdata, Date =='1/2/2007')
sub2powerdata <- subset(powerdata, Date =='2/2/2007')

subpowerdata <- merge(x = sub1powerdata, y = sub2powerdata, by = "Date", all = TRUE)


sample2data <- subpowerdata[,c(1,2,3,11)]

replacenull <- function(x) {
        if ( is.na(as.numeric(as.character(x))) ) return( 0)
        return(as.numeric(as.character(x)))
}

gendate <- function(x,y){
   if ( is.na(as.character(y)) ) return( paste (x, "00:00:00"))
   return( paste(x,y))

}


cleantime <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    mydate <- gendate(a,b)
    mydate <- as.POSIXct(strptime(mydate, "%d/%m/%Y %H:%M:%S"))

    return ( mydate)
}

clean2 <- function( x ) {
    a <- x[c(1)]
    b <- x[c(2)]
    c <- x[c(3)]
    d <- x[c(4)]
    mydata <- replacenull(c) + replacenull(d)
    mydata <- as.numeric(as.character(mydata))

    return (  mydata)
}

xt <- apply(sample2data, 1, cleantime) 
yt <- apply(sample2data, 1, clean2)

class(xt) <- c('POSIXt','POSIXct')

plot(yt ~ xt, type ="l",xaxt="n", ylab = "Global Active Power (kilowatts)")
axis.POSIXct(1, at = xt, format = "%H\n%a")
dev.copy(png,'plot2.png',width=480,height=480)
dev.off()
