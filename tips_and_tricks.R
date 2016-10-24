
# Setting locales
Sys.setlocale("LC_ALL", "English") # For everything
Sys.setlocale("LC_CTYPE", "en_US.UTF-8") # For dealing with text only

# Logical difference between vectors (leave only elements that belong to the first vector but don't belong to the other one)
'%nin%' <- Negate('%in%')
vect <- c(1,2,3)
vect %nin% c(1,4,5)
vect[vect %nin% c(1,4,5)]


# Select columns of data frame by name
df <- setNames(data.frame(as.list(1:5)), LETTERS[1:5])
# Select only columns with names "A", "B" and "E"
df[,c("A","B","E")]


# Pre-read dtaframe (read head of it first, then read the whole data frame with corresponding classes)
head_df <- read.csv(file_name, stringsAsFactors = FALSE, header = TRUE, nrows = 1)
df <- read.csv(file_name, stringsAsFactors = FALSE, colClasses = rep("character", ncol(head_df)))
rm(head_df)


# Reorder columns of a data frame - just select them by names in the necessary order
reordered_df <- df[, c("col3", "col1", "col2")]

# Send email from R with on line of code
# Rscript -e 'sendmailR::sendmail("<hanna.rudakouskaya@gmail.com>", "<hanna.rudakouskaya@gmail.com>", "Test", list(body = sendmailR::mime_part("test!")), control=list(smtpServer="ASPMX.L.GOOGLE.COM", smtpPort="25"))'

# Working with dates
format(as.POSIXct("07:05:45PM", format="%I:%M:%S%p"), "%H:%M:%S")

# Complete cleanup (remove all the variables in workspace)
rm(list=ls(all=TRUE))