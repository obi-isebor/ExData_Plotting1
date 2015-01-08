# =============================================================================
# R-script to read electric power consumption data, subset to 2007-02-01 and
# 2007-02-02 dates, and create a trellised time-series line plots of global
# active power, voltage, all three energy sub-metering categories, and global
# reactive power.
# This code assumes that the data set file "household_power_consumption.txt"
# is in the same working directory as this plot4.R file.
# =============================================================================

# ==========================================
# === Section to read in and format data ===
# ==========================================

# Read in data from provided input file
data <- read.table("household_power_consumption.txt", header = T, sep = ";", 
                   na.strings = "?", stringsAsFactors = FALSE)

# Select observations in required date range
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Merge Date and Time character columns to create new Date_Time column
data$Date_Time <- paste(data$Date,data$Time)

# Rearrange data frame such that Date_Time is first variable, and 
# ignore separate Date and Time columns
data <- subset(data, select = c(10, 3:9))

# Convert Date_Time from character to actual Date/Time (POSIXlt) format
data$Date_Time <- strptime(data$Date_Time, "%d/%m/%Y %H:%M:%S")

# ==========================================
# === Section to generate required plots ===
# ==========================================

# Open png device
png(file = "plot4.png")

# Create 2 by 2 plot matrix
par(mfrow = c(2,2))

# Fill in plot matrix with required plots
with(data, {plot(Date_Time, Global_active_power, type = "l", 
                 ylab = "Global Active Power", xlab = "")
            plot(Date_Time, Voltage, type = "l", xlab = "datetime")
            plot(Date_Time, Sub_metering_1, type = "l", 
                 ylab = "Energy sub metering", xlab = "")
            lines(Date_Time, Sub_metering_2, col = "red")
            lines(Date_Time, Sub_metering_3, col = "blue")
            legend("topright", lty = 1, 
                   col = c("black", "red", "blue"),
                   legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3")
                   )
            plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime")
            }
     )

# Close png device and create required file in working directory
dev.off()