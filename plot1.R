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

## Plot Histogram as per requiremnst for Plot 1
hist(pc$Global_active_power, main = paste("Global Active Power"), 
     col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
