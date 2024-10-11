# read data
powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

# Create column in table with date and time concatenated
FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerdata <- cbind(powerdata, FullTimeDate)

# transforming data. This takes some time but is necesarry
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

# subsetting for only 2007-02-01 and 2007-02-02 data
subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")

# actual plot
png("plot2.png", width=480, height=480)

# Baseplot without x axis labels (due to inaccessible language)
with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n"))

# Extract weekday from 'FullTimeDate' column
days <- format(subsetdata$FullTimeDate, "%a")

# Set the positions and labels for the X-axis (based on unique days)
axis(1, at = c(min(subsetdata$FullTimeDate), median(subsetdata$FullTimeDate), max(subsetdata$FullTimeDate)), labels = c("Thu", "Fri", "Sat"))

dev.off()