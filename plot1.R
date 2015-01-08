# =============================================================================
# R-script to read electric power consumption data, subset to 2007-02-01 and
# 2007-02-02 dates, and create a histogram plot of Global Active Power.
# This code assumes that the data set file "household_power_consumption.txt"
# is in the same working directory as this plot1.R file.
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
png(file = "plot1.png")

# Generate required histogram of Global_active_power on screen device,
# with title, x-label and color red
with(data, hist(Global_active_power, main = "Global Active Power",
                xlab = "Global Active Power (kilowatts)", col = "red"))

# Close png device and create required file in working directory
dev.off()