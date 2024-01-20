from pymongo import MongoClient
import re

conx = MongoClient("mongodb://localhost:27017/")

db = conx["gst_stg"]

stagiaires = db["Stagiaires"]

examens = db["Examens"]

passerExamen = db["PasserExamen"]

# Q1
for s in stagiaires.find() :
    print(s)

# Q2
for e in examens.find() :
    print(e)

# Q3
for s in stagiaires.find({}, {"nom": 1, "prenom": 1}) :
    print(s)

# Q4
for e in examens.find({}, {"NumE": 1, "Date": 1}) :
    print(e)

# Q5
for s in stagiaires.find().sort("NomS", -1) :
    print(s)

# Q6
for e in examens.find({"Type": "p"}).sort("Date") :
    print(e)

# Q7
for p in passerExamen.find({"NumS": "S01"}, {"_id": 0, "NumE": 1, "Note": 1, "NumS": 0, "Salle": 0}).sort("Note") :
    print(p)

# Q8
for p in passerExamen.find({"Salle": {"$in": ["A2", "A3"]}}) :
    print(p)

# Q9
for p in passerExamen.find({"$and": [{"NumS": "S01"}, {"Note": {"$gte": 15}}]}) :
    print(p)

# Q10
for p in passerExamen.find({"Note": {"$gt": 15}}, {"_id": 0, "NumE": 0, "Note": 0, "NumS": 1, "Salle": 0}) :
    print(p)

# Q11
for p in passerExamen.find({"NumS": "S01"}, {}).limit(2) :
    print(p)

# Q12
for s in stagiaires.find({"NomS": {"$regex": "^A"}}) :
    print(s)

# or
pattern = re("/^A/")
for s in stagiaires.find({"NomS": {"$regex": pattern}}) :
    print(s)

# Q13
print("Le Nombre Des Examens Est: " + examens.count_documents())

# Q14
print("Le Nombre Des Examens Passer Dans La Salle B5 Est: " + examens.count_documents({"Salle": "B5"}))

# Q15
for p in passerExamen.find({"NumE": {"$in": ["E01", "E02", "E03"]}}, {"_id": 0, "NumE": 0, "Note": 0, "NumS": 1, "Salle": 0}) :
    print(p)