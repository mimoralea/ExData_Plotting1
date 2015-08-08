filename <- "household_power_consumption.txt"

if (!file.exists(filename)) {
    tmp_filename <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", tmp_filename, "curl")
    unzip(tmp_filename)
    unlink(tmp_filename)
}

pcons <- read.table(filename, header=TRUE, sep=";", stringsAsFactors=FALSE)
pcons <- pcons[pcons$Date %in% c("1/2/2007","2/2/2007") ,]

datetime <- strptime(paste(pcons$Date, pcons$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

sm1 <- as.numeric(pcons$Sub_metering_1)
sm2 <- as.numeric(pcons$Sub_metering_2)
sm3 <- as.numeric(pcons$Sub_metering_3)

png("plot3.png", width=480, height=480)

plot(datetime, sm1, type="l", ylab="Energy Submetering", xlab="")

lines(datetime, sm2, type="l", col="red")
lines(datetime, sm3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
