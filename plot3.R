filename <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## if data file is not found then pull it from
## the url given with the assignment
## clean up the zip file and only keep the
## inner text file
if (!file.exists(filename)) {
    tmp_filename <- tempfile()
    if (download.file(url,
                      tmp_filename,
                      "curl") != 0) {
        stop("the file failed to download, will not proceed")
    }
    unzip(tmp_filename)
    unlink(tmp_filename)
}

## load the specific data and clean values to be able to plot them
pcons <- read.table(filename, skip = 66636, nrows = 2880, sep = ";")
names(pcons) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
                  "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## get variables to plot
datetime <- strptime(paste(pcons$Date, pcons$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
sm1 <- pcons$Sub_metering_1
sm2 <- pcons$Sub_metering_2
sm3 <- pcons$Sub_metering_3

## do the actual plotting
png("plot3.png", width=480, height=480)
plot(datetime, sm1, type="n", ylab="Energy sub metering", xlab="")
lines(datetime, sm1, type="l", col="black")
lines(datetime, sm2, type="l", col="red")
lines(datetime, sm3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
