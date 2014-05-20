library(XML)
library(stringr)

# URL address
connection.url  <- 'http://www.gutenberg.org/files/10/10-h/10-h.htm'

# Parse HTML
testament.html <- htmlTreeParse(connection.url, useInternalNodes=T)
xpathSApply(testament.html, '//title', xmlValue) # check for known nodes, i.e. //title

# Access top node
testament.xml <- xmlRoot(testament.html)
class(testament.xml)

# Extract XML codes using xmlSapply
testament.doc <- xmlSApply(testament.xml, function(x) xmlSApply(x, xmlValue))
class(testament.doc)

testament.list <- rapply(testament.doc, c)
testament.frame <- data.frame(testament.list, stringsAsFactors=F)
testament.frame.dup <- testament.frame[!duplicated(testament.frame), ]
unique(testa)

write.csv(testament.frame, file='Old Testament.csv', sep=',')






b1 <- str_extract_all(string = testament.list, pattern = '[0-9][0-9]:[0-9][0-9]')

# Test
testament.list <- rapply(b1, c)
b1.frame <- data.frame(b1, c)
class(testament.list)

testament.frame <- data.frame(testament.list, stringsAsFactors=F)

# Convert XML codes and text into dataframe
testament.df <- data.frame(testament.list)
testament.df <- data.frame(testament.doc)
class(testament.df)
t
str_extract_all(string = a, pattern = "\\(.*?\\)")

[0-9][0-9]:[0-9][0-9]