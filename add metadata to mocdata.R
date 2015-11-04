setwd:("C:\Users\kelly.robinson\Dropbox\Cowen_Sponaugle\OSTRICH\PhysData\mocness\MOCDATA")

#STEP 1:Import and clean up RV_WS mocdata files

(d<-list.files(pattern = ".PRO", full.names=T, recursive=FALSE))
for(i in 1:length(d))

  #read file in  
  data <- read.table(d[33], skip = 161)
  colnames(data, do.NULL = FALSE)
  colnames(data) = c("time", "pres","echo","temp","theta","sal","sigma","angle","flow","hzvel","vtvel","vol","net","fluor","ptran","oxygen","Irradcurrent","Irradiance","lat","lon")
  
  #add "HaulNo" field: **needs to changed for each file
  data["HaulNo"] <- NA
  data$HaulNo <- "M4-028" #HaulNo of MOCNESS tow;

  #add "Cruise" field
  data["Cruise"] <- NA
  data$Cruise <- "OSTRICH 2014"

  #add "WS_MOCFileName" field
  data["WS_MOCFileName"] <- NA
  data$WS_MOCFileName <- paste(basename(d[33]))

  #remove the first line of data because it is usually collected on the deck of the ship
  data <- subset(data, data$sigma>0)

  #remove net 5 data because it doesn't exist
  data <- subset(data, net<=4)

  #write new csv file
  write.csv(data, "output/M4-028.csv", row.names=FALSE, quote=FALSE, na = "NA")

#STEP 2: Append multiple files in the same directory into a single, large dataset

  #clear working environment
  rm(list=ls())
  
  #Set directory
  setwd("C:\\Users\\kelly.robinson\\Dropbox\\Cowen_Sponaugle\\OSTRICH\\PhysData\\mocness\\MOCDATA\\output")

  #Getting a List of Files in working directory
  file_list <- list.files()

  #Merging the Files into a Single Dataframe
  for (file in file_list){
  
  # if the merged dataset doesn't exist, create it
    if (!exists("dataset")){
    #dataset <- do.call("rbind",lapply(file_list, FUN=function(files){read.table(file, header=TRUE, sep=",")}))
    dataset <- ldply(file_list, read.table, header=TRUE, sep=",")
  }

  
  # if the merged dataset does exist, append to it
  if (exists("dataset")){
    temp_dataset <-read.table(file, header=TRUE, sep=",")
    dataset<-rbind(dataset, temp_dataset)
    rm(temp_dataset)
  }
    
}