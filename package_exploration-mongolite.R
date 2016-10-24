
library(mongolite)

# Connect
connection <- mongo(collection = "collection_name", url = "mongodb://user_name:user_password@ip_or_domain:port_usually_27017/collection_name")
whole_collection <- connection$find() # Get all the data from collection
rm(connection) # Disconnect

# Aggregate example
data <- connection_name$aggregate(pipeline = '[{"$group" : { "_id" : "$some_factor_to_group", "count": { "$sum": 1 } }}]')
data <- connection_name$aggregate(pipeline = '[{"$group" : { "_id" : "$some_factor_to_group", "count": { "$sum": 1 } }}, {"$sort": {"_id": 1}}]')