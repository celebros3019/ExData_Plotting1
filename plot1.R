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
filter(household, Date == household$Date[68248]) -> Feb_2
rbind(Feb_1, Feb_2) -> dataset

hist(as.numeric(dataset$Global_active_power), freq = T) -> histoR1


png()
png("plot1.png", width = 480, height = 480)
plot(histoR1, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
graphics.off()