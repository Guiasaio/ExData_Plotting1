############## EXPLORATORY DATA ANALYSIS ##############
"Course Project 1"
############# GUILHERME ASAI OLIVEIRA #############
############# PLOT 3 #############
#install.packages("data.table")
library("ggplot2")
library("data.table")
#Make sure the data is in the Working DIrectory
#Read only from the first occurrance of 2007-02-01 to the last of 2007-02-02 (2880 minutes = 2 days * 24 hours * 60 minutes)
#I've used the fread function because it's faster than read.csv
HPC = fread("household_power_consumption.txt", sep = ";", verbose = F, showProgress = F, skip = "1/2/2007", nrows = 2880)
#Create a header with proper column names
header = fread("household_power_consumption.txt", header = F, sep = ";", verbose = F, showProgress = F, nrows = 1)
#Define the column names of HPC using header
colnames(HPC) = as.character(header)
#Change HPC class from data.table to data.frame
HPC = as.data.frame(HPC)
#Concatenate Date and Time and format it
HPC$Date = strptime(paste(HPC$Date, HPC$Time), format = "%d/%m/%Y %H:%M:%S")
#Remove the Time column of my data.frame
HPC$Time = NULL
#Plots in current device, a single graph
par(mfrow=c(1,1)) 
plot(HPC$Date, HPC$Sub_metering_1, type = "l", xlab = "Date", ylab = "Sub metering")
lines(HPC$Date, HPC$Sub_metering_2, col = "red")
lines(HPC$Date, HPC$Sub_metering_3, col = "blue")
legend('topright', legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c('black', 'red', 'blue'), lty = 1)
dev.set(which = 2)
#Prints plot from current device (RStudioGD) to selected device
dev.print(device = png, file = "plot3.png", width = 480, height = 480)
dev.prev()
