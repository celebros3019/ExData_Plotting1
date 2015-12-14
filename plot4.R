# Download zip file ("exdata-data-household_power_consumption.zip") into the forked repo.
# This will use the packages dplyr, tidyr, and lubridate; they must be installed for this to work.

setwd("c:/Users/Teresa/Documents/GitHub/datasciencecoursera/ExData_Plotting1")
unzip("exdata-data-household_power_consumption.zip") -> data
read.table(data[1], header=T) -> household
require(dplyr)
tbl_df(household)
require(tidyr)
separate(household, col = Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3, into = c("Date", "Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), sep = ";") -> household

require(lubridate)
dmy(household$Date) -> household$Date

group_by(household, Date) -> household
filter(household, Date == household$Date[67248]) -> Feb_1
mutate(Feb_1, dt = as.POSIXct(paste(Feb_1$Date, Feb_1$Time), format = "%Y-%m-%d %H:%M:%S")) -> Feb_1
filter(household, Date == household$Date[68248]) -> Feb_2
mutate(Feb_2, dt = as.POSIXct(paste(Feb_2$Date, Feb_2$Time), format = "%Y-%m-%d %H:%M:%S")) -> Feb_2
rbind(Feb_1, Feb_2) -> dataset

png()
png("plot3.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(dataset$dt, as.numeric(dataset$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(dataset$dt, as.numeric(dataset$Voltage), type = "l", ylab = "Voltage", xlab = "datetime")
plot(dataset$dt, as.numeric(dataset$Sub_metering_1), type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(dataset$dt, as.numeric(dataset$Sub_metering_2), type = "l", col = "red", ylab = "Energy sub metering", xlab = "")
lines(dataset$dt, as.numeric(dataset$Sub_metering_3), type = "l", col = "blue", ylab = "Energy sub metering", xlab = "")
legend("topright", pch = "___", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(dataset$dt, as.numeric(dataset$Global_reactive_power), type = "l", ylab = "Global_reactive_power", xlab = "datetime")
graphics.off()