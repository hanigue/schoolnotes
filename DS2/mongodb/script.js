// Vytvoreni kolekce
db.createCollection("artists")
db.createCollection("albums")

// ---- DATA ------
db.artists.save({_id: "sunmi0317", name: "Seonmi Lee", 
				company: "JYP", debut: 2014, albums: ["noir0216", "swan0414"]})
db.artists.save({_id: "chungha0416", name: "Kim Chungha",
				company: "Star Entertainment", debut: 2016, albums: ["hello0317"]})
db.artists.save({_id: "heize0213", name: "Heize", 
				company: "Self-publishing", debut: 2013, albums: ["july0715"]})
db.artists.save({_id: "yubin0307",name: "Kim Yubin",
				company: "JYP", debut: 2007, albums: ["lady0211"]})
db.artists.save({_id: "jessi0805", name: "Hakimhan",
				company: "PSY", debut: 2005, albums: ["queen0718"]})

db.albums.insert({_id: "noir0216", artist: "sunmi0317", name: "Noir",
				 nosongs: 3, 
				 songs: [{title: "Siren", genre: "contemporary", playcount: 4000}, {title: "Noir",  genre: "contemporary", playcount: 4460},{title:"Lalalay", genre: "pop", playcount: 54700}],
				 language: ["english","korean"],
				 producers: ["Sunmi","JYP"],
				 release: "02-04-2016"})
db.albums.insert({_id: "swan0414", artist: "sunmi0317", name: "Swan",
				 nosongs: 2, 
				 songs: [{title: "Full Moon",  genre: "contemporary", playcount: 40600},{title:"24 Hours", genre: "contemporary", playcount: 54700}],
				 language: ["chinese","korean"],
				 producers: ["JYP"], release: "04-04-2014"})
db.albums.insert({_id: "hello0317", artist: "chungha0416", name: "Hello", 
				 nosongs: 3, 
				 songs: [{title:"Roller Coaster",  genre: "dance", playcount: 3800},{title:"Snapping",  genre: "hip-hop", playcount: 3500},{title: "Why",  genre: "pop", playcount: 4688}],
				 language: ["japanese","korean"],
				 producers: ["Brave brothers"], release: "03-06-2017"})
db.albums.insert({_id: "july0715", artist: "heize0213", name: "July", language: ["korean"],
				 nosongs: 2,
				 songs: [{title: "Shut up and Groove",  genre: "hip-hop", playcount: 2300}, {title:"Rain",  genre: "hip-hop", playcount: 2780}],
				 producers: ["Heize","Dean"],
				 release: "07-02-2015"})
db.albums.insert({_id: "lady0211", artist: "yubin0307", name: "Lady", 
				 nosongs: 1, 
				 songs: [{title: "Lady",  genre: "city-pop", playcount: 5700}], 
				 language: ["korean"],
				 producers: ["Yubin","JYP"],
				 release: "02-08-2011"})
db.albums.insert({_id: "queen0718", artist: "jessi0805", name: "Queen",
				 nosongs: 3, 
				 songs: [{title: "Who dat B", genre: "hip-hop", playcount: 3200}, {title: "Gucchi", genre: "rap", playcount: 3000},{title: "Strong Unnie", genre: "EDM", playcount: 2400}],
				 language: ["english","korean"],
				 producers: ["Jessi"], release: "07-09-2018"})

db.artists.update(
{ _id: "sunmi0317" },
{ name: "Sunmi", company: "Banana Entertainment",
  debut: 2014, albums: ["noir0216", "swan0414"]})

db.artists.update(
	{_id: "chaeyeon1319"},
	{name: "Chaeyeon Lee", company: "Star Entertainment", debut: 2020},{ upsert: true })

db.albums.update( { _id: "queen0718" }, {  $push: {songs: "Drop"}, $inc: {nosongs: 1} } )

// ---- QUERIES ------

// Alba, ktera jsou POUZE v korejstine
db.albums.find({$and: [{language: "korean"}, {language: {$size: 1}}]},{name:1, language:1}).forEach(printjson)

// Alba, ve ktere je popularni rap pisnicka (playcount je vyssi nez 2000)
db.albums.find({songs: {$elemMatch: {genre: "rap",playcount: {$gte: 2000}}}},{_id:0,name:1}).forEach(printjson)

// Vsechny artists, kteri nemaji ve jmene "Kim"
db.artists.find({name: {$not: /^.*[K|k]im.*/}},{name:1}).sort({name:1}).forEach(printjson)

// Alba, ktery maji vic pisnicek nez 3 nebo je to jen single album
db.albums.find({$or: [{nosongs: {$gte: 3}},{nosongs: 1}]},{_id:0,name:1}).forEach(printjson)

// Artists, kteri debutovali v roce 2014 - 2016 a chci vratit pouze jedno z alb, pokud jich maji vice
db.artists.find({debut: { $gte: 2014, $lte: 2016 }},{_id:1, albums: {$slice:1}}).forEach(printjson)

// ---- MAPREDUCE ------
// Vypsat pisnicky z alb, ktera obsahovala vice nez 3 pisnicky. 
// Jednotliva alba jsou serazene po letech vydani.


printjson(
db.albums.mapReduce(
    function() {
        release = this.release.substring(this.release.length-4,this.release.length);
        for (var i = 0; i < this.songs.length; i++) {
            emit(release, this.songs[i].title);
        }
    },
    function(key, values) {
        return values.sort().toString();
    },
    {
        query: { nosongs: { $gte: 3 } },
        out: { inline: 1 }
    }));
