# install.packages('bigrquery')

library(bigrquery)
project <- "codegym-test" 
sql <- 'SELECT title,contributor_username,comment FROM[publicdata:samples.wikipedia] WHERE title CONTAINS "beer" LIMIT 100;'
data <- query_exec(sql, project)
