# Read the data
powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";")

# Create a column in the table with date and time merged together
FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerdata <- cbind(powerdata, FullTimeDate)

# Change the class of all columns to the correct class
powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

# Subset the data for the dates 2007-02-01 and 2007-02-02
subsetdata <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")

# Plot the 4 graphs
png("plot4.png", width=480, height=480)

# Set the layout for 2x2 plots
par(mfrow=c(2,2))

# 1st plot: Global Active Power
with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt="n"))
# Add custom X-axis labels (Thu, Fri, Sat)
axis(1, at = c(min(subsetdata$FullTimeDate), median(subsetdata$FullTimeDate), max(subsetdata$FullTimeDate)), labels = c("Thu", "Fri", "Sat"))

# 2nd plot: Voltage
with(subsetdata, plot(FullTimeDate, Voltage, type = "l", xlab="datetime", ylab="Voltage", xaxt="n"))
# Add custom X-axis labels (Thu, Fri, Sat)
axis(1, at = c(min(subsetdata$FullTimeDate), median(subsetdata$FullTimeDate), max(subsetdata$FullTimeDate)), labels = c("Thu", "Fri", "Sat"))

# 3rd plot: Energy sub metering
with(subsetdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n"))
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_2, type="l", col="red")
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))
# Add custom X-axis labels (Thu, Fri, Sat)
axis(1, at = c(min(subsetdata$FullTimeDate), median(subsetdata$FullTimeDate), max(subsetdata$FullTimeDate)), labels = c("Thu", "Fri", "Sat"))

# 4th plot: Global Reactive Power
with(subsetdata, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power", xaxt="n"))
# Add custom X-axis labels (Thu, Fri, Sat)
axis(1, at = c(min(subsetdata$FullTimeDate), median(subsetdata$FullTimeDate), max(subsetdata$FullTimeDate)), labels = c("Thu", "Fri", "Sat"))

# Close the PNG device
dev.off()