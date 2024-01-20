use tp2;
db.createCollection("Film");

db.Film.insertMany([
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
]);

//Q1
db.Film.find();

//Q2
db.Film.find({}, { "title": 1, genre: 1, _id: 0 });

//Q3
db.Film.find({ "genre": { "$nin": ["Action", "Comédie", "Science Fiction"] } });

//Q4
db.Film.find({ "releaseYear": { "$gt": 2015 } });

//Q5
db.Film.find({ "director": "Steven Spielberg" });

//Q6
db.Film.find({ "actors": "Leonardo DiCaprio" });

//Q7
db.Film.find({ "rating": { "$lt": 8.0 } });

//Q8
db.Film.find({ "releaseYear": { "$gte": 2000, "$lte": 2010 } });

//Q9
db.Film.find({ "title": { "$regex": /Dark/, "$options": 'i' } });

//Q10
db.Film.find().sort({ "rating": -1 });

//Q11
db.Film.find().sort({ "releaseYear": -1 }).limit(5);

//Q12
db.Film.distinct("director");

//Q13
db.Film.find({ "releaseYear": 2010 }).count();
