# =============================================================================
# R-script to read electric power consumption data, subset to 2007-02-01 and
# 2007-02-02 dates, and create a time-series line plot for all three energy 
# sub-metering categories.
# This code assumes that the data set file "household_power_consumption.txt"
# is in the same working directory as this plot3.R file.
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

# Open png device and create required file in working directory
png(file = "plot3.png")

# Generate line plot of Sub_metering_1 vs time on screen device,
# with only a y-label, then add lines for sub_metering_2 (red) 
# and sub_metering_3 (blue), lastly add legend
with(data, {plot(Date_Time, Sub_metering_1, type = "l", 
                 ylab = "Energy sub metering", xlab = "")
            lines(Date_Time, Sub_metering_2, col = "red")
            lines(Date_Time, Sub_metering_3, col = "blue")
            legend("topright", lty = 1, 
                   col = c("black", "red", "blue"),
                   legend = c("Sub_metering_1", "Sub_metering_2",
                              "Sub_metering_3")
                   )
            }
     )

# Close png device and create required file in working directory
dev.off()