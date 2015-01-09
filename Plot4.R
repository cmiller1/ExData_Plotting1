##Exploratory Data Analysis - Course Projects
##Step 1 - Setting up a matrix of column variables
col.name.data<-c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##Step 2 - Read the data, but only for the relevant rows
z<-read.table("household_power_consumption.txt", header=T, sep=";", skip=66636, nrows=2880, col.names=col.name.data, colClasses=c("character", "character", rep("numeric",7)))

##Step 3 - Two operations to create a new column variable with R formatted date and time
z$DT <- paste(z$Date, z$Time, sep=" ")
z$final <- strptime(z[,10], "%d/%m/%Y %H:%M:%S")

##Step 4 - Plotting the histogram
par(mfrow=c(2,2))
with(z,{
  plot(z$final, z$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  plot(z$final, z$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(z$final, z$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(z$final, z$Sub_metering_2, col="red")
  lines(z$final, z$Sub_metering_3, col="blue")
  legend("topright", lty=1,col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bg = "transparent", box.col = "transparent", cex = 0.55)
  plot(z$final, z$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}
)

##Step 5 - Saving the plot to a png file and closing the device
dev.copy(png, file="plot4.png", width = 480, height = 480, units = "px")
dev.off()
