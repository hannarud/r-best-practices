# https://rollingyours.wordpress.com/2016/06/29/express-intro-to-dplyr/
# https://rollingyours.wordpress.com/2016/07/07/express-dplyr-part-ii/

library(readr)
library(dplyr)

url <- "http://steviep42.bitbucket.org/YOUTUBE.DIR/weather.csv"
download.file(url,"weather.csv")

system("head -5 weather.csv")  # Take a peak at the first 5 lines

weather <- read_csv("weather.csv")

weather

# Or another way to read-in data

dp_mtcars <- tbl_df(mtcars)

class(dp_mtcars)

# Find all rows where MPG is >= 30 and Weight is over 1.8 tons
filter(dp_mtcars, mpg >= 30 & wt > 1.8)

# Finds columns whose nqme starts with “x”
select(dp_mtcars,starts_with("m"))

# Get all columns except columns 5 through 10 
select(dp_mtcars,-(5:10))

# Transform the wt variable by multiplying it by 1,000 and then create a new variable called “good_mpg” which takes on a value of “good” or “bad” depending on if a given row’s MPG value is > 25 or not
mutate(dp_mtcars, wt=wt*1000, good_mpg=ifelse(mpg > 25,"good","bad"))

COMMAND	PURPOSE
select()	Select columns from a data frame
filter()	Filter rows according to some condition(s)
arrange()	Sort / Re-order rows in a data frame
mutate()	Create new columns or transform existing ones
group_by()	Group a data frame by some factor(s) usually in conjunction to summary
summarize()	Summarize some values from the data frame or across groups
inner_join(x,y,by=”col”)	return all rows from ‘x’ where there are matching values in ‘x’, and all columns from ‘x’ and ‘y’. If there are multiple matches between ‘x’ and ‘y’, all combination of the matches are returned.
left_join(x,y,by=”col”)	return all rows from ‘x’, and all columns from ‘x’ and ‘y’. Rows in ‘x’ with no match in ‘y’ will have ‘NA’ values in the new columns. If there are multiple matches between ‘x’ and ‘y’, all combinations of the matches are returned.
right_join(x,y,by=”col”)	return all rows from ‘y’, and all columns from ‘x’ and y. Rows in ‘y’ with no match in ‘x’ will have ‘NA’ values in the new columns. If there are multiple matches between ‘x’ and ‘y’, all combinations of the matches are returned
anti_join(x,y,by=”col”)	return all rows from ‘x’ where there are not matching values in ‘y’, keeping just columns from ‘x’
