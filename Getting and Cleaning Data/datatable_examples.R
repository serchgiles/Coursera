# How to use the data.table package
# install.packages("data.table")
library(data.table)

df <- data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), 
                 z = rnorm(9))
head(df,3)

DT <- data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), 
                 z = rnorm(9))
head(DT,3)

# Tell us how many data.tables in our worskspace.
tables()

# Subsetting works as in dataframes. If column index is not provided, then
# it would subset over the rows
DT[c(2,4),]
DT[c(2,4)]

# If column index is provided then it would find the [i,j] entry
DT[2,2]

# Performing the operations by passing a list
DT[,list(mean(x), toupper(y))]

# Adding a new variable. This modifies our original data.table.
DT[, w:= z^2]

# Create multi-step operations by setting them into curly braces {}
DT[,m:={tmp<-(x+z);log2(tmp+5)}]

# Create a binary variable and perform operations grouping by this new column
DT[,a:= x>0]

# Here we perform the mean of x+w grouping by those which a value is TRUE and
# by those which have FALSE
DT[, b:= mean(x+w), by=a]

###############
# Special variables

# .N counts how many variables are and can be grouped by another one column. 
# This just summaries but keeps the original data.table
set.seed(123)
DT2 <- data.table(x=sample(letters[1:3], 1e5, T))
tables()
DT2[, .N, by=x]

################
# KEYS
DT3 <- data.table(x=rep(letters[1:3], each = 100), y=rnorm(300))
# If we set a key for this datatable then call:
setkey(DT3, x)

# By doing this, now we can subset in the following way:
DT3['a']

# Also, can use Keys to facilitates joins between tables:

DT4 <- data.table(x=c("a", "a", "b", "dt1"), y =1:4)
DT5 <- data.table(x=c("a", "b", "dt2"), z=5:7)
setkey(DT4, x); setkey(DT, x)
data.table::merge.data.table(DT4, DT5)
