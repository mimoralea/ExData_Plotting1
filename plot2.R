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
gap <- as.numeric(pcons$Global_active_power)

png("plot2.png", width=480, height=480)

plot(datetime, gap, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
