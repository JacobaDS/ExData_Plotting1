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

#To construct the plots, I need to paste Date & Time together (=datetime)
data2$datetime <- strptime(paste(data2$Date, data2$Time), "%Y-%m-%d %H:%M:%S")  
str(data2)  

#plot 4. Consists of 4 sub-plots, to be placed in a 2 x 2 frame. 
#I will fill row-wise; from left up to right up to left bottom to right bottom. So I use par(mfrow(2,2))
par(mfrow = c(2, 2)) #note to self: do not forget the c
#plot 4.1  Almost the same as plot 2, but without (kilowatts) on the y-axis
plot(data2$datetime,data2$Global_active_power,ylab="Global Active Power",xlab="",type="l")

#plot 4.2, to be placed in the right upper corner 
plot(data2$datetime,data2$Voltage,ylab="Voltage",xlab="datetime",type="l")

#Plot 4.3, to be placed in the left lower corner. This is plot 3 as made before, but then without the box surrounding the legend:
plot(data2$datetime,data2$Sub_metering_1,ylab="Energy sub metering",xlab="",type="l")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "),col=c("black","red","blue"),lty=1,bty="n",cex=0.75)
#bty = type of box to be drawn around the legend. cex:  amount by which plotting text and symbols should be magnified relative to the default

#Plot 4.4, to be placed in the right lower corner.
plot(data2$datetime,data2$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")

#save it to a PNG file with a width of 480 pixels and a height of 480 pixels (plot1.png)
#Copy plot to png file:
dev.copy(png, file="plot4.png", width=480, height=480) #gaat niet goed, _1 valt eraf in de png
#Close PNG device:
dev.off()


