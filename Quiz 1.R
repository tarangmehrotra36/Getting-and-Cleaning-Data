# Download the file and codebook
quiz1.1 <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                       destfile = "./quiz1-1.csv")
quiz1.1 <- read.csv(file = "quiz1-1.csv", sep = ",")

# Codebook - https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# and load the data into R. The code book, describing the variable names is here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# 1. How many housing units in this survey were worth more than $1,000,000?
quiz1.1.q1 <- subset(quiz1.1, VAL > 23)
nrow(quiz1.1.q1)

# 2. Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

# 3. Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
# dat
# What is the value of:
# sum(dat$Zip*dat$Ext,na.rm=T)
library(xlsx)
quiz1.2 <- download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
                         destfile = "./quiz1-2.xlsx")
quiz1.2 <- read.xlsx(file = "quiz1-2.xlsx",sheetIndex=1)

quiz1.2 <- read.xlsx(file = "getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1)
dat <- read.xlsx(file = "getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1, rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# Read the XML data on Baltimore restaurants from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zipcode 21231?

# Sample code 
# fileUrl <- "http://www.w3schools.com/xml/simple.xml"
# doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
# rootNode <- xmlRoot(doc)
# xmlName(rootNode)

install.packages("XML")
library(XML)

# Read XML to R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
restaurants <- download.file(fileUrl, destfile="./restaurants.xml")
doc <- xmlTreeParse(file = "restaurants.xml", useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

# Directly access parts of the XML document
names(rootNode)
rootNode[[1]][[1]]

# Programatically extract parts of the file
xmlSApply(rootNode, xmlValue)

# Get the ZIP
zipcode <- (xpathSApply(rootNode,"//zipcode", xmlValue))
sum(zipcode == 21231)

# The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about 
# housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# using the fread() command load the data into an R object
# DT
# Which of the following is the fastest way to calculate the average value of the variable
# pwgtp15 
# broken down by sex using the data.table package?

install.packages("data.table")
library(data.table)

quiz1.q5 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# Fread
download.file(quiz1.q5, destfile = "./quiz1-5.csv") <- fread(quiz1.q5)
DT <- read.csv(file = "quiz1-5.csv", sep = ",")
write.table(DT, file = "quiz1-5.csv", sep = ",")

system.time(DT <- read.csv(file = "quiz1-5.csv", sep = ","))
system.time(write.table(DT, file = "quiz1-5.csv", sep = ","))



names(DT)
head(DT)

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
system.time(c(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)))

mean(DT$pwgtp15,by=DT$SEX)
system.time(mean(DT$pwgtp15,by=DT$SEX))

# Answer
DT[,mean(pwgtp15),by=SEX]

rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]

system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))