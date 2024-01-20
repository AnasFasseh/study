from pymongo import MongoClient
from datetime import datetime

conx = MongoClient("mongodb://localhost:27017/")

db = conx["tp2"]

# A
Film = db["Film"]

Film.insert_one(
    {
        "title": "Inception",
        "genre": "Science Fiction",
        "releaseYear": 2010,
        "director": "Christopher Nolan",
        "actors": ["Leonardo DiCaprio", "Ellen Page", "Tom Hardy"],
        "rating": 8.7
    },
)

# 1
Film.update_one({"title": "Inception"}, {"$inc": {"rating": 0.3}})

# 2
Film.delete_many({"releaseYear": {"$lt": 2000}})

# 3
Film.update_one({"title": "Inception"}, {"$set": {"budget": "100M$"}})

# 4
Film.update_many({"director": "Christopher Nolan"}, {"$push": {"actors": "Cillian Murphy"}})

# 5
Film.delete_many({"rating": {"$lt": 5.0}})

# 6
Film.update_many({"genre": "Science Fiction"}, {"$set": {"releaseYear": 2015}})

# 7
Film.update_many({"$and": [{"genre": "Science Fiction"}, {"releaseYear": {"$gt": 2010}}]}, {"$inc": {"rating": 0.5}})

# 8
Film.delete_many({"genre": {"$nin": ["Science Fiction", "Action"]}})

# 9
Film.update_many({"reviews": {"$exists": False}}, {"$set": {"reviews": []}})

# 10
Film.update_many({}, {"$set": {"age": {"$subtract": [datetime.now(), "$releaseYear"]}}})

# 11
Film.delete_many({"actors": []})

# 12
Film.update_many({"releaseYear": {"$gt": 2010}}, {"$set": {"titre": {"$concat": ["$titre", " 3D"]}}})