from pymongo import MongoClient

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
for f in Film.aggregate([{"$group": {"_id": "genre", "moyenne": {"$avg": "$rating"}}}]) :
    print(f)

# 2
for f in Film.aggregate([{"$group": {"_id": "director", "nbr_film": {"$sum": 1}}}]) :
    print(f)

# 3
for f in Film.aggregate([{"$match": {"actors": {"$in": ["Leonardo DiCaprio"]}}}]) :
    print(f)

# 4
for f in Film.aggregate([{"$sort": {"rating": -1}}, {"$limit": 10}]) :
    print(f)

# 5
for f in Film.aggregate([{"$group": {"_id": {"releaseYear": "$releaseYear", "genre": "$genre"}, "nbr_film": {"$sum": 1}}}]) :
    print(f)