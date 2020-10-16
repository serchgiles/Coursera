# WEEK 3 QUIZ
setwd(dir = "Getting and Cleaning Data/")
'%p%' <- function(a,b) paste0(a,b)
library(dplyr)
#-----------------------------------------------------------------------------#
# link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download.file(link, "Samples and to-load data/IDAHO_housing_2006.csv")

datos <- read.csv("Samples and to-load data/IDAHO_housing_2006.csv")
agricultureLogical <- (datos$ACR==3 & datos$AGS==6)

which(agricultureLogical)
#-----------------------------------------------------------------------------#
# image.link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
# download.file(image.link, "Samples and to-load data/instructor.jpeg")

img <- jpeg::readJPEG(source = "Samples and to-load data/instructor.jpeg", 
                      native = T)

quantile(img, c(0.3,0.8))

#-----------------------------------------------------------------------------#

# gross.link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
# download.file(gross.link, "Samples and to-load data/gross_domestic.csv")
# 
# educa.link <- "https://d396qusza40orc.cloudfront.net/" %p% 
#                 "getdata%2Fdata%2FEDSTATS_Country.csv"
# download.file(educa.link, "Samples and to-load data/educational_data.csv")

gross <- read.csv("Samples and to-load data/gross_domestic.csv", skip = 4, 
                  nrows = 190, dec = ".", )
gross$X.4 <- as.numeric(gsub(pattern = ",", replacement = "", x = gross$X.4))
education <- read.csv("Samples and to-load data/educational_data.csv")

join.data <- gross %>% 
        inner_join(education, by = c("X" = "CountryCode")) %>% 
        arrange(X.4)

join.data %>% group_by(Income.Group) %>% summarise(mean(X.1))

join.data$quantgroup <- cut(join.data$X.1, 
                            breaks = quantile(join.data$X.1, 
                                              probs = seq(0,1,length.out = 6)))
table(join.data$quantgroup, join.data$Income.Group) %>% View()

