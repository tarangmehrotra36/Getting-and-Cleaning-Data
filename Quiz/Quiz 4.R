# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?
q4.1 <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ',
                         './Quiz/getdata%2Fdata%2Fss06hid.csv', mode='wb')
q4.1 <- read.csv('./Quiz/getdata-data-ss06pid.csv', header=T, sep=',')
q4.1.name <- names(q4.1)
strsplit(q4.1.name, 'wgtp')[[123]]

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table 
q4.2 <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
                      './Quiz/getdata%2Fdata%2FGDP.csv', mode='wb')
q4.2 <- read.csv('./Quiz/getdata%2Fdata%2FGDP.csv', sep=',', header=T, skip=4)
q4.2 <- q4.2[-191:-326,]
q4.2 <- q4.2[,-3]; q4.2 <- q4.2[,-5:-9]
colnames(q4.2) <- c('Code', 'GDP.Rank', 'countryNames', 'GDP')
q4.2$GDP <- as.numeric(gsub(pattern=',',replacement='', x=q4.2$GDP))
mean(q4.2[,4])

# In the data set from Question 2 what is a regular expression that would allow you to count 
# the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United? 
attach(q4.2)
grep(pattern='^United', x=countryNames)
grep("^United",countryNames)
detach(q4.2)

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats
q4.4.1 <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
                      './Quiz/getdata%2Fdata%2FGDP.csv', mode='wb')
q4.4.1 <- read.csv('./Quiz/getdata%2Fdata%2FGDP.csv', sep=',', header=T, skip=4)
q4.4.1 <- q4.4.1[-191:-326,]
q4.4.1 <- q4.4.1[,-3]; q4.4.1 <- q4.4.1[,-5:-9]
colnames(q4.4.1) <- c('CountryCode', 'GDP.Rank', 'Short.Name', 'GDP')
q4.4.2 <- download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv',
                      './Quiz/getdata%2Fdata%2FEDSTATS_Country.csv', mode='wb')
q4.4.2 <- read.csv('./Quiz/getdata%2Fdata%2FEDSTATS_Country.csv', header=T, sep=',')
q4.4 <- merge(x=q4.4.1, y=q4.4.2, by='CountryCode')
q4.4.complete <- subset(q4.4, subset=Special.Notes != '')
grep(pattern='^Fiscal year end: June', x=q4.4.complete$Special.Notes)

# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for 
# publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled. 
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
install.packages('quantmod')
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

amzn <- as.data.frame(amzn)
amzn$Date <- as.Date(paste(sampleTimes))
amzn$Weekday <- weekdays(amzn$Date, abbreviate=T)

library(gmodels)
CrossTable(x=year(amzn$Date), y=amzn$Weekday, expected=F, prop.r=F, prop.c=F, prop.t=F, prop.chisq=F)