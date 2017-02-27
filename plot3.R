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

#plot 3. Simply plot(x,y,..). With x=datetime & y= energy sub metering (1, 2 & 3).
#I start with the plot of sub metering 1 (as this has the default colour black). 
#Then, I add lines for sub metering 2 (in red) & 3 (in blue).
#Finally, I construct the legend, in the upper right corner.
plot(data2$datetime,data2$Sub_metering_1,ylab="Energy sub metering",xlab="",type="l")
lines(data2$datetime,data2$Sub_metering_2,col="red")
lines(data2$datetime,data2$Sub_metering_3,col="blue")
#legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))
#not yet perfect: no lines shown. Help page of legend says: lty (linetypes) and/or lwd (line widths) must be specified for line drawing.
legend("topright",legend=c("Sub_metering_1    ","Sub_metering_2    ","Sub_metering_3    "),col=c("black","red","blue"),lty=1)
#spaces added, otherwise the legend is not readable anymore in de PNG file

#save it to a PNG file with a width of 480 pixels and a height of 480 pixels (plot1.png)
#Copy plot to png file:
dev.copy(png, file="plot3.png", width=480, height=480) #gaat niet goed, _1 valt eraf in de png
#Close PNG device:
dev.off()


