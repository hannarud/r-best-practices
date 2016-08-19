
# Aggregate example
data <- connection_name$aggregate(pipeline = '[{"$group" : { "_id" : "$some_factor_to_group", "count": { "$sum": 1 } }}]')
data <- connection_name$aggregate(pipeline = '[{"$group" : { "_id" : "$some_factor_to_group", "count": { "$sum": 1 } }}, {"$sort": {"_id": 1}}]')