#Load data
hpc_raw <- "./household_power_consumption.txt"
data <- read.csv(hpc_raw, header=TRUE, sep=";", 
                 stringsAsFactors=FALSE, dec=".")

#Adjust date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data_subset$Date), data_subset$Time)
data_subset$Datetime <- as.POSIXct(datetime)

#Subset data
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset$Global_reactive_power <- as.numeric(data_subset$Global_reactive_power)
data_subset$Voltage <- as.numeric(data_subset$Voltage)

#Set variables of interest to numeric
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)

#Make plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(data_subset$Datetime, data_subset$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power", cex=0.2)

plot(data_subset$Datetime, data_subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(data_subset$Datetime, data_subset$Sub_metering_1, type="l", 
     ylab="Energy Submetering", xlab="")
lines(data_subset$Datetime, data_subset$Sub_metering_2, type="l", col="red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(data_subset$Datetime, data_subset$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

dev.off()