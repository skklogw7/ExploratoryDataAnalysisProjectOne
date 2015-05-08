#Load data
hpc_raw <- "./household_power_consumption.txt"
data <- read.csv(hpc_raw, header=TRUE, sep=";", 
                 stringsAsFactors=FALSE, dec=".")
#Adjust date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset data
data_subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Adjust date format
datetime <- paste(as.Date(data_subset$Date), data_subset$Time)
data_subset$Datetime <- as.POSIXct(datetime)

#Set global_active_power variable to numeric
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)

#Make plot
png("plot2.png", width=480, height=480)
plot(data_subset$Datetime, data_subset$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()

