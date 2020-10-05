## Getting and Cleaning Data 

#' Check if we already working directory
new.dir <- "Getting and Cleaning Data"
if(!file.exists(new.dir)){dir.create(new.dir)}else{setwd(new.dir)}

# Pasting character values with an operator
'%p%' <- function(a,b) paste0(a,b)

#' Downloading some data from Baltimore Fixed Speed Cameras

# Fix the url from the downloadable file is located on the web
file_url <- "https://data.baltimorecity.gov/api" %p%
               "/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

# Set the destfile name
download.file(file_url, destfile = "baltimoredata.csv", method = "curl")
list.files()
# Useful to track when it was downloaded
downloadedDate <- date()

cameraData <- read.csv(file = "baltimoredata.csv")
head(cameraData)

# Reading XML files 
library(XML)

fileurl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileurl, useInternal = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
