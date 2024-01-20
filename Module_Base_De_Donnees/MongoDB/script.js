use gst_stg
db.createCollection("Stagiaires")
db.createCollection("Examens")
db.createCollection("PasserExamen")

//la collection stagiaires
db.Stagiaires.insertMany([
    {
        NumS: 1,
        NomS: "Fasseh",
        PrenomS: "Anas",
        Tel: "0603020104"
    }, 
    {
        NumS: 2,
        NomS: "BM",
        PrenomS: "Anas",
        Tel: "0603020104",
        email: "anas@gmail.com"
    },  
    {
        NumS: 3,
        NomS: "Zrouial",
        PrenomS: "Aimrane"
    },
    {
        NumS: 4,
        NomS: "BK",
        PrenomS: "Oussama",
        email: "oussama@gmail.com"
    },
    
    {
        NumS: 5,
        NomS: "Billa",
        PrenomS: "Amine",
        email: "amine@gmail.com"
    }
    
])
db.Stagiaires.find({})

//la collection examens
db.Examens.insertMany([
    {
        NumS: 1,
        NomS: "Fasseh",
        PrenomS: "Anas",
        Tel: "0603020104"
    }, 
    {
        NumS: 2,
        NomS: "BM",
        PrenomS: "Anas",
        Tel: "0603020104",
        email: "anas@gmail.com"
    },  
    {
        NumS: 3,
        NomS: "Zrouial",
        PrenomS: "Aimrane"
    },
    {
        NumS: 4,
        NomS: "BK",
        PrenomS: "Oussama",
        email: "oussama@gmail.com"
    },
    
    {
        NumS: 5,
        NomS: "Billa",
        PrenomS: "Amine",
        email: "amine@gmail.com"
    }
    
])
db.Examens.find({})