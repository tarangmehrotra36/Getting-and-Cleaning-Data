# sudo apt-get install libcurl4-openssl-dev
# sudo apt-get install libxml2-dev

install.packages('RCurl', dep=T)
library(RCurl)
quiz3url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
quiz3url <- getURL(quiz3url, ssl.verifypeer=0L, followlocation=1L)

writeLines(quiz3url, 'quiz3.csv')
quiz3 <- read.csv('quiz3.csv', sep=',', header=T)
head(quiz3)
str(quiz3)

summary(quiz3$ACR)
summary(quiz3$AGS)

q1 <- quiz3$ACR == 3 & quiz3$AGS == 6
q1.1 <- which(q1)
q1.1[1:3]

# Using the jpeg package read in the following picture of your instructor into R
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
install.packages('jpeg', dep=T)
library(jpeg)
quiz3.2url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
quiz2.2 <- download.file(quiz3.2url, 'getdata%2Fjeff.jpg', mode='wb')
leek <- readJPEG('getdata%2Fjeff.jpg', native=T)
unclass(leek)[c(30,80)] # Incorrect
quantile(leek,c(0.3,0.8))



# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats
q3.31 <- read.csv('getdata_data_GDP.csv', sep=',', header=T)
q3.32 <- read.csv('getdata_data_EDSTATS_Country.csv', sep=',', header=T)
q3.3 <- merge(q3.31, q3.32, by='CountryCode')

q3.sort <- q3.3[order(-q3.3$Ranking),] # Sort by Ranking
nrow(q3.sort); q3.sort[13,1:3]

# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
tapply(X=q3.sort$Ranking, INDEX=q3.sort$Income.Group, mean)


# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
breaks <- quantile(q3.sort$Ranking, probs=c(0, .2, .4, .6, .8, 1))
q3.sort$Cut <- cut(q3.sort$Ranking, breaks=breaks, labels=c('Q1', 'Q2', 'Q3', 'Q4', 'Q5'), include.lowest = TRUE)

table(q3.sort$Cut, q3.sort$Income.Group)



