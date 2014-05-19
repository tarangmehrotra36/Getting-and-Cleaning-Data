# HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)

h5 <- h5read("getdata-data-h5ex_d_extern.h5", "DS1")
head(h5)
colSums(h5)


h5url <- "http://www.hdfgroup.org/ftp/HDF5/examples/files/exbyapi/h5ex_d_extern.h5"
download.file(h5url, destfile = "h5ex_d_extern.h5.h5", mode = "w")
h5.1 <- h5read("h5.h5", "DS1")

h5.1

install.packages("RMySQL", type = "source")
install.packages("RMySQL", 
                 repos = "http://cran.r-project.org/src/contrib/RMySQL_0.9-3.tar.gz")
library(RMySQL)


# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
# http://biostat.jhsph.edu/~jleek/contact.html 
# (Hint: the nchar() function in R may be helpful)

html <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode <- readLines(html)
close(html)
htmlcode
library(XML)
htmlparse <- htmlTreeParse(htmlcode, useInternalNodes = T)
htmlparse
nchar(htmlparse[10,])

library(httr)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html2 <- GET(url)
content2 <- content(html2, as = "text")
parsedhtml <- htmlParse(content2, asText = T)
xpathSApply(parsedhtml, "//title", xmlValue)

# Read this data set into R and report the sum of the numbers in the fourth column. 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# (Hint this is a fixed width file format)
fordata <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fordata, destfile = "fordata.for")
for.data <- read.table("fordata.for")
for