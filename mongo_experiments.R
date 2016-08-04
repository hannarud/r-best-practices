library(mongolite)

con <- mongo(collection = "test", db = "test", url = "mongodb://localhost", verbose = TRUE)


# con$insert(tax_sale_data)
con$count()

# con$drop()

mydata <- con$find(query = '{"county_unique_code": "12127"}')
alldata <- con$find()

rm(con)
gc()


taxsaledata <- gettaxsalecon$find()
rm(gettaxsalecon)


names(taxsaledata)
