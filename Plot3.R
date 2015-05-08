#Load data
hpc_raw <- "./household_power_consumption.txt"
data <- read.csv(hpc_raw, header=TRUE, sep=";", 
                 stringsAsFactors=FALSE, dec=".")

#Adjust date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data_subset$Date), data_subset$Time)

#Subset data
data_subset$Datetime <- as.POSIXct(datetime)

#Set variables of interest to numeric
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)

#Make plot
png("plot3.png", width=480, height=480)
plot(data_subset$Datetime, data_subset$Sub_metering_1, type="l", 
     ylab="Energy Submetering", xlab="")

lines(data_subset$Datetime, data_subset$Sub_metering_2, type="l", col="red")
lines(data_subset$Datetime, data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()