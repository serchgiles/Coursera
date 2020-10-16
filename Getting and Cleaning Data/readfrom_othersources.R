# Other formats and how to load them

# HDF5
# install.packages("BiocManager")
# BiocManager::install(pkgs = "rhdf5")

library(rhdf5)
created <- h5createFile("example.h5")
created

created <- h5createGroup("example.h5", "foo")
created <- h5createGroup("example.h5", "baa")
created <- h5createGroup("example.h5", "foo/foobaa")
h5ls()

# WEB SCRAPPING
'%p%' <- function(a,b) paste0(a,b)

link <- "https://scholar.google.com/citations?" %p% 
        "view_op=list_works&hl=es&user=I56_37UAAAAJ"
con <- url("https://scholar.google.com/citations?view_op=list_works&hl=es&user=I56_37UAAAAJ")
htmlCode <- readLines(con)
close(con) # ALWAYS CLOSE THE URL CONNECTION
htmlCode

# XML package
library(XML)
html <- htmlTreeParse(link, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)


# HTTR package
library(httr)
html2 <- GET(link)
content2 <- content(html2, as = "text")
parsedHtml <- htmlParse(content2, asText = T)
xpathSApply(parsedHtml, "//title", xmlValue)


