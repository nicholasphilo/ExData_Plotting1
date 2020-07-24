### Loading Required packages
library(lubridate)


### Downloading data set if needed:


if(  !file.exists("household_power_consumption.txt")  ){
    
    dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    
    download.file(dataset_url, destfile = "unzipme.zip", method = "curl")
    unzip("unzipme.zip")
    
    
}

### Reading and conditioning the dataset:

df <- read.table(  "household_power_consumption.txt" , sep = ";" , header = TRUE,
                   colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                   na.strings = "?"
)

con1 <-  which(  df$Date == "1/2/2007" | df$Date == "2/2/2007")
df <- df[  con1  ,]

### Creating a time variable:

df$date_time <- paste(  df$Date , df$Time , sep = " "  )
df$date_time <- parse_date_time(  df$date_time , orders =  "d/m/y H:M:S")



########################################################################################################################################################################

### Producing plot

png(  "plot4.png" , res =  )

par(  mfrow = c(2,2)  )

# plot1

plot(df$Global_active_power ~ df$date_time, type = "l" , xlab = "", ylab = "Global Active Power (Kilowatts)")

# plot2

plot(  df$Voltage ~ df$date_time  ,  type = "l"  , xlab = "datetime", ylab = "Voltage"  )

# plot3

plot(df$date_time  ,  df$Sub_metering_1  , type = "l", xlab = "", ylab = "Energy sub metering")
points(df$date_time  ,  df$Sub_metering_2  , type = "l", col = 2)
points(df$date_time  ,  df$Sub_metering_3  , type = "l", col = 4  , )
legend( x = "topright"   , legend = c("sub meter 1","sub meter 2","sub meter 3"), col = c(1,2,4) , lty = 1 )

# plot4

plot(  df$Global_reactive_power ~ df$date_time  ,  type = "l"  , xlab = "datetime", ylab = "Global Reactive Power"  )


dev.off()


