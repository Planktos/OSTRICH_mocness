#Add Latitude and Longitude to MOCDATA files (non-binned data) so you can create plots of the tow in ODV
library(data.table)

options(digits.secs = 3)

setwd("C:/Users/kelly.robinson/Dropbox/Cowen_Sponaugle/OSTRICH/PhysData/mocness/MOCDATA/output")
m <- fread("mocdata.csv")
moc <- as.data.frame(m)

#Create Date field
moc$Date <- NA
moc$Date <- as.Date(moc$time-1, origin = "2014-01-01")
moc$t <- as.character(moc$time)

moc$t1 <- substr(moc$t, start = 4, 8)
moc$t1 <- as.numeric(moc$t1)
moc$t1 <- (moc$t1*24) - 4 #Convert GMT time to local time
moc$hour <- floor(moc$t1)


#Convert decimal hours to minutes
moc$t2 <- substr(moc$t, start = 4, 8)
moc$t2 <- as.numeric(moc$t2)
moc$t2 <- (((moc$t2*24) - 4) - 14)
moc$t2 <- moc$t2*60
moc$min <- floor(moc$t2)


#Convert decimal minutes to seconds
moc$sec <- (moc$t2-moc$min)*60

moc$sec <- as.character(moc$sec)
moc$min <- as.character(moc$min)
moc$hour <- as.character(moc$hour)

moc$Time <- NA
moc$Time <- paste0(moc$hour,":",moc$min, ":", moc$sec)
options(digits.secs = 3)
moc$Time <- chron(times. = moc$Time)
moc$Time < - format.POSIXlt(moc$Time, digits.secs = 3, format = )

