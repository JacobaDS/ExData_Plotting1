# NOTE TO REVIEWERS: THIS CODES ASSUMES THAT THE UNZIPPED DATA IS IN YOUR WORKING DIRECTORY
# REASONING: THE ASSIGNMENT PRESCRIBED "YOUR CODE FILE SHOULD INCLUDE CODE FOR READING THE DATA" 
# so, no code for downloading & unzipping included here

# setwd("D:/My Data/PersonalFiles_for_Backup/CursusDataScientist/DS_04/wk1/data")
# load data into R. Note: missing values are coded as ?. The file is ; seperated and has a header.

data <- read.table("household_power_consumption.txt", sep=";", na.strings="?" , stringsAsFactors = FALSE, header= TRUE)
str(data) # => Date and Time are characters, all other columns are numeric
head(data)

# Firstly, convert Date from character to Date, using day-month-year as follows:
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
str(data)

#We will only be using data from the dates 2007-02-01 and 2007-02-02.
#Note to self: code below did not work using which(), but does work without using which():
data2 <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

#To construct plot 2, I need to paste Date & Time together (=datetime)
data2$datetime <- strptime(paste(data2$Date, data2$Time), "%Y-%m-%d %H:%M:%S")  
str(data2)  

#plot 2. Simply plot(x,y,..). With x=datetime & y= global_active_power.
#plot(data2$datetime,data2$Global_active_power,ylab="Global Active Power (kilowatts)")
#Not yet perfect: omit x-label (data2$datetime) and draw a line instead of points (=> type is l for lines):
plot(data2$datetime,data2$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")

#save it to a PNG file with a width of 480 pixels and a height of 480 pixels (plot1.png)
#Copy plot to png file:
dev.copy(png, file="plot2.png", width=480, height=480)
#Close PNG device:
dev.off()


