## read the input data file
input_file<- "household_power_consumption.txt"
pc<-read.table(input_file, header=T, sep=";")

## Convert Date from factor format to date format
pc$Date <- as.Date(pc$Date, format="%d/%m/%Y")

## Subset to relevant dates
pc <- subset(pc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Concatenate and Convert to datetime/timestamp format
pc_datetime <- paste(as.Date(pc$Date), pc$Time)
pc$datetime <- as.POSIXct(pc_datetime)

## Convert data fields in input file to numeric values
pc$Global_active_power <- as.numeric(as.character(pc$Global_active_power))
pc$Global_reactive_power <- as.numeric(as.character(pc$Global_reactive_power))
pc$Voltage <- as.numeric(as.character(pc$Voltage))
pc$Sub_metering_1 <- as.numeric(as.character(pc$Sub_metering_1))
pc$Sub_metering_2 <- as.numeric(as.character(pc$Sub_metering_2))
pc$Sub_metering_3 <- as.numeric(as.character(pc$Sub_metering_3))

## Open png Graphics device,customize plotting area,and create plots as per requirements for Plot4
png(filename = "plot4.png",
    width = 480, height = 480)
par(mfcol=c(2,2))
plot(pc$Global_active_power~pc$datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
plot(pc$datetime,pc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(pc$datetime,pc$Sub_metering_2,col="red")
lines(pc$datetime,pc$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.85)
plot(pc$datetime, pc$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
plot(pc$datetime,pc$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")
dev.off()