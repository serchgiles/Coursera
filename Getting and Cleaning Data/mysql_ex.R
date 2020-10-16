# Connection with MySQL
library(DBI)
library(RMySQL)

'%p%' <- function(a,b) paste0(a,b)

ucscDb <- DBI::dbConnect(MySQL(), user = "genome", 
                         host = "genome-mysql.soe.ucsc.edu")
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

# All databases available in the server
result

# Particular database
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", 
                  host = "genome-mysql.soe.ucsc.edu")

# All the tables
all.tables <- dbListTables(hg19)
length(all.tables)
all.tables[1:5]

# List all the fields of particular table
dbListFields(hg19, "affyU133Plus2")

# Get the data obtained by passing some query in SQL-language
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

# Extracts the table as a dataframe
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# Specifics subquery
query <- "select * from affyU133Plus2 where misMatches" %p%
        " between 1 and 3"
# This stores the results remotely at the db
subquery <- dbSendQuery(hg19, query)

# Now we return the result by fetching the subquery
affyMis <- fetch(subquery); quantile(affyMis$misMatches)

# If we want a quick view of our result, set n=10
affyMisSmall <- fetch(subquery, n=10)
dim(affyMisSmall)

# Clear our query from the remote database
dbClearResult(subquery)

# ALWAYS CLOSE THE CONNECTION
dbDisconnect(hg19)
