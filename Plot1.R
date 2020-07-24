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

png(  "plot1.png"  )

hist(  df$Global_active_power ,
       col = "red" ,
       xlab = "Golbal Active Power (Kilowatts)",
       main = "Global Active Power"
)

dev.off()


