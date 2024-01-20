use tp4;

db.film.insertOne({
 "title": "Inception",
 "genre": "Science Fiction",
 "releaseYear": 2010,
 "director": "Christopher Nolan",
 "actors": ["Leonardo DiCaprio", "Ellen Page", "Tom Hardy"],
 "rating": 8.7
}
);

//Q 1
db.film.aggregate([{"$group": {"_id": "$genre", "noteMoy": {"$avg": "$rating"}}}]);

//Q 2
db.film.aggregate([{"$group": {"_id": "$director", "nbr_film": {"$count": "$_id"}}}]);

//Q 3
db.film.aggregate([{"$match": {"actors": "Leonardo DiCaprio"}}]);

//Q 4
db.film.aggregate([{"$sort": {"rating": -1}}, {"$limit": 10}]);

//Q 5
db.film.aggregate({"$group": { _id: {"annee":"$releaseYear", "genre": "$genre"}, "nbr_film": {$sum: 1}}});