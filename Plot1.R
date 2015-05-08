#Load data
hpc_raw <- "./household_power_consumption.txt"
data <- read.csv(hpc_raw, header=TRUE, sep=";", 
                   stringsAsFactors=FALSE, dec=".")
#Adjust date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset data
data_subset <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Set Global_active_power to numeric
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)

#Make plot
png("plot1.png", width=480, height=480)
hist(data_subset$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

