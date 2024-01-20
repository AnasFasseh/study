use("gst_stg");

//question 1
db.Stagiaires.find();

//question 2
db.Examens.find();

//question 3
db.Stagiaires.find({}, { NomS: 1, PrenomS: 1, _id: 0 });

//question 4
db.Examens.find({}, { NumE: 1, Date: 1 });

//question 5
db.Stagiaires.find().sort({ NomS: -1, _id: 0 });

//question 6
db.Examens.find({ Type: "p" }, { _id: 0 }).sort({ Date: 1 });

//question 7
db.PasserExamen.find({ NumS: { $eq: "S01" } }, { NumE: 1, Note: 1 }).sort({
  Note: 1,
});

//question 8
db.Examens.find({ Salle: { $in: ["A2", "A3"] } }, {});

//question 9
db.PasserExamen.find(
  { $or: [{ NumS: "S01" }, { Note: { $gte: 15 } }] },
  { NumE: 1, Note: 1 }
);

//question 10
db.PasserExamen.find({ Note: { $gt: 15 } }, { NumS: 1 });

//question 11
db.PasserExamen.find({ NumS: "S01" }, {}).limit(2);

//question 12
db.Stagiaires.find({ NomS: { $regex: /^A/ } }, {});

//question 13
db.Examens.find().count();

//question 14
db.Examens.find({ Salle: "B5" }).count();

//question 15
db.PasserExamen.find({ NumE: { $in: ["E01", "E02", "E03"] } }, { NumS: 1 });
