##############################################################################
# STEP 1 - Download & Store data
##############################################################################

if (!dir.exists("./Expl_Plot_Asgnmnt1")) {
    dir.create("./Expl_Plot_Asgnmnt1")        
} 
setwd("./Expl_Plot_Asgnmnt1")

zipfileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfilename <- "household_power_consumption.zip"

if (!file.exists(zipfilename)){
    download.file(zipfileURL,zipfilename,mode = "wb")
} else{
    file.remove(zipfilename)
    download.file(zipfileURL,zipfilename,mode = "wb")
}

unzip(zipfilename,overwrite = TRUE)

##############################################################################
# STEP 2 - Subplot Data, Convert Date and Time & Delete unwanted Data to 
#          recover memory
##############################################################################

df_HH_POW_CNSM <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE)
df_HH_POW_CNSM$Date <- as.Date(df_HH_POW_CNSM$Date,format="%d/%m/%Y")

# SUBSET the data for 2 days

df_HH_POW_CNSM <- df_HH_POW_CNSM[(df_HH_POW_CNSM$Date == "2007-02-01") | (df_HH_POW_CNSM$Date == "2007-02-02"), ]

df_HH_POW_CNSM$Global_active_power <- as.numeric(as.character(df_HH_POW_CNSM$Global_active_power))
df_HH_POW_CNSM$Global_reactive_power <- as.numeric(as.character(df_HH_POW_CNSM$Global_reactive_power))
df_HH_POW_CNSM$Voltage <- as.numeric(as.character(df_HH_POW_CNSM$Voltage))
df_HH_POW_CNSM$Global_intensity <- as.numeric(as.character(df_HH_POW_CNSM$Global_intensity))
df_HH_POW_CNSM$Sub_metering_1 <- as.numeric(as.character(df_HH_POW_CNSM$Sub_metering_1))
df_HH_POW_CNSM$Sub_metering_2 <- as.numeric(as.character(df_HH_POW_CNSM$Sub_metering_2))

##############################################################################
# STEP 3 - Generate and store the plot in file device
##############################################################################

hist(df_HH_POW_CNSM$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
