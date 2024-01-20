use tp2;
db.Film.insertOne({
 "title": "Inception",
 "genre": "Science Fiction",
 "releaseYear": 2010,
 "director": "Christopher Nolan",
 "actors": ["Leonardo DiCaprio", "Ellen Page", "Tom Hardy"],
 "rating": 8.7
})
db.Film.find()

//Q 1
db.Film.updateOne(
 { _id: ObjectId("658bf7f393764ecea4912b2e") },
 { $inc: { rating: 0.3 } }
);

//Q 2
db.Film.deleteMany({"releaseYear": {"$lt": 2000}});

//Q 3
db.Film.updateOne(
{"_id": ObjectId("658bf7f393764ecea4912b2e")},
{$set: {"budjet": "100M $"}}
);

//Q 4
db.Film.updateMany(
{"director": "Christopher Nolan"},
{$push: {"actors": "Cillian Murphy"}}
);

//Q 5
db.Film.deleteMany({"rating": {"$lt": 5}});

//Q 6
db.Film.updateMany(
{"genre": "Science Fiction"},
{$set: {"releaseYear": 2015}}
);

//Q 7
db.Film.updateMany(
{"genre": "Science Fiction", "releaseYear": {"$gt": 2010}},
{$inc: {"rating": 0.5}}
);

//Q 8
db.Film.deleteMany({"genre": {"$nin": ["Science Fiction", "Action"]}});

//Q 9
db.Film.updateMany(
{},
{$addToSet: {"reviews": []}}
);

//Q 10
function getDate() {
  let date_sys = new Date().getFullYear();
  let date = [];
};
db.Film.updateMany(
{},
{$set: {"age": new Date().getFullYear() - "$releaseYear"}}
);

//Q 11
db.Film.updateMany(
{},
{$pull: {"actors": []}}
);

//Q 12
db.Film.updateMany(
{"releaseYear": {"$gt": 2010}},
{$set: {"title": {$concat: ["$title", "3D"]}}}
);