from pymongo import MongoClient

conx = MongoClient("mongodb://localhost:27017/")

db = conx["tp2"]

# A
Film = db["Film"]

# B
Film.insert_many([
    {
        "title": "Inception",
        "genre": "Science Fiction",
        "releaseYear": 2010,
        "director": "Christopher Nolan",
        "actors": ["Leonardo DiCaprio", "Ellen Page", "Tom Hardy"],
        "rating": 8.7
    },
    {
        "title": "Interstellar",
        "genre": "Science Fiction",
        "releaseYear": 2014,
        "director": "Christopher Nolan",
        "actors": ["Matthew McConaughey", "Anne Hathaway", "Jessica Chastain"],
        "rating": 8.6
    },
    {
        "title": "The Matrix",
        "genre": "Action",
        "releaseYear": 1999,
        "director": "Lana Wachowski, Lilly Wachowski",
        "actors": ["Keanu Reeves", "Laurence Fishburne", "Carrie-Anne Moss"],
        "rating": 8.7
    },
    {
        "title": "Pulp Fiction",
        "genre": "Crime",
        "releaseYear": 1994,
        "director": "Quentin Tarantino",
        "actors": ["John Travolta", "Uma Thurman", "Samuel L. Jackson"],
        "rating": 8.9
    }
])

# C
# 1
for f in Film.find() :
    print(f)

# 2
for f in Film.find({}, {"title": 1, "genre": 1, "releaseYear": 0, "director": 0, "actors": 0, "rating": 0}) :
    print(f)

# 3
for f in Film.find({"genre": {"$nin": ["action", "comedie", "science fiction"]}}) :
    print(f)

# 4
for f in Film.find({"releaseYear": {"$gt": 2015}}) :
    print(f)

# 5
for f in Film.find({"director": "Steven Spielberg"}) :
    print(f)

# 6
for f in Film.find({"actors": {"$in": ["Leonardo DiCaprio"]}}) :
    print(f)

# 7
for f in Film.find({"rating": {"$lt": 8.0}}) :
    print(f)

# 8
for f in Film.find({"$and": [{"releaseYear": {"$gte": 2000}}, {{"releaseYear": {"$lte": 2010}}}]}) :
    print(f)

# 9
for f in Film.find({"title": {"$regex": "%Dark%"}}) :
    print(f)

# 10
for f in Film.find().sort("rating", -1) :
    print(f)

# 11
for f in Film.find().sort("releaseYear", -1).limit(5) :
    print(f)

# 12
print(Film.distinct("director"))

# 13
print("Le Nombre De Films De L'annee 2010 est: " + Film.count_documents({"releaseYear": 2010}))