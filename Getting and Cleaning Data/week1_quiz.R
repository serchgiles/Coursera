# WEEK 1 QUIZ
'%p%' <- function(a,b) paste0(a,b)

file_url <- "https://d396qusza40orc.cloudfront.net/" %p% 
                "getdata%2Fdata%2Fss06hid.csv"

download.file(file_url, destfile = "dataQ1.csv", method = "curl")

df <- read.csv("dataQ1.csv")
df <- as.data.table(df)

# How many properties are worth $1,000,000 or more?
df[, .N, by=VAL]

# Question 3
excel_url <- "https://d396qusza40orc.cloudfront.net/" %p% 
                "getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(excel_url, destfile = "excelfile.xlsx", method = "curl")

library(readxl)
dat <- readxl::read_excel("excelfile.xlsx", range = "A18:O23")
sum(dat$Zip*dat$Ext,na.rm=T)

# Question 4
library(XML)

xml_url <- "https://d396qusza40orc.cloudfront.net/" %p% 
                "getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(xml_url)

# Question 5 

csv_url <- "https://d396qusza40orc.cloudfront.net/" %p% 
                "getdata%2Fdata%2Fss06pid.csv"

download.file(csv_url, destfile = "Idaho_housing.csv", method = "curl")

DT <- fread("Idaho_housing.csv")

DT$pwgtp15

