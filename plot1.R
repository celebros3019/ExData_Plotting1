# Download zip file ("exdata-data-household_power_consumption.zip") into the forked repo.
# This will use the packages tidyr, and lubridate. They must be installed for this to work.
# Replace the first line with your personal working directory.

setwd("c:/Users/Teresa/Documents/GitHub/datasciencecoursera/ExData_Plotting1")

  require(tidyr)
  require(lubridate)

  unzip("exdata-data-household_power_consumption.zip") -> data
    read.table(data[1], header=T) -> household
      separate(household, col = Date.Time.Global_active_power.Global_reactive_power.Voltage.Global_intensity.Sub_metering_1.Sub_metering_2.Sub_metering_3,
              into = c("Date", "Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
              "Sub_metering_1","Sub_metering_2","Sub_metering_3"), sep = ";") -> household
        dmy(household$Date) -> household$Date
          household[household$Date == ymd("2007-02-01 UTC"),] -> Feb_1
          household[household$Date == ymd("2007-02-02 UTC"),] -> Feb_2
            rbind(Feb_1, Feb_2) -> dataset

hist(as.numeric(dataset$Global_active_power), freq = T) -> histoR1

png()

  png("plot1.png", width = 480, height = 480)
    plot(histoR1,
         col = "Red",
         main = "Global Active Power",
         xlab = "Global Active Power (kilowatts)")

graphics.off()