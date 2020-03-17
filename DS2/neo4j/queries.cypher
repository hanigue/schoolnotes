CREATE
  (a1:ARTIST { id: "sunmilee07", name: "Sunmi Lee", debut: 2007, company: "JYP"}),
  (a2:ARTIST { id: "chunghakim14", name: "Chungha", debut: 2014, company: "Banana Ent"}),
  (a3:ARTIST { id: "heize16", name: "Heize", debut: 2016}),
  (a4:ARTIST { id: "jessiho03", name: "Jessi", debut: 2003, company: "Psy Ent"}),

  (b1:ALBUM { id: "a-noir", name: "Lalalay", release: 2016}),
  (b2:ALBUM { id: "a-snapping", name: "Snapping", release: 2018}),
  (b3:ALBUM { id: "a-july", name: "And July", release: 2014}),
  (b4:ALBUM { id: "a-gucchi", name: "Gucchi", release: 2015}),
  
  (s1:SONG { id: "s-lalalay", name: "Lalalay", duration: 190, genre: "EDM"}),
  (s2:SONG { id: "s-siren", name: "Siren", duration: 185, genre: "Dance"}),
  (s3:SONG { id: "s-24hours", name: "24 Hours", duration: 187, genre: "Contemporary"}),
  (s4:SONG { id: "s-fullmoon", name: "Full Moon", duration: 173, genre: "Contemporary"}),
  (s5:SONG { id: "s-addict", name: "Addict", duration: 189, genre: "EDM"}),
  
  (s6:SONG { id: "s-snapping", name: "Snapping", duration: 193, genre: "Hip-Hop"}),
  (s7:SONG { id: "s-gottago", name: "Gotta Go", duration: 186, genre: "Hip-Hop"}),
  (s8:SONG { id: "s-chico", name: "Chico", duration: 187, genre: "Pop"}),
  
  (s9:SONG { id: "s-andjuly", name: "And July", duration: 186, genre: "Hip-Hop"}),
  (s10:SONG { id: "s-gucchi", name: "Gucchi", duration: 187, genre: "Pop"}),
  

  (a1)-[sing1:SING]->(b1), 
  (a2)-[sing2:SING]->(b2),
  (a3)-[sing3:SING]->(b3), 
  (a4)-[sing4:SING]->(b4),

  (b2)-[c1:CONTAIN]->(s6),
  (b2)-[c2:CONTAIN]->(s7),
  (b2)-[c3:CONTAIN]->(s8),

  (b1)-[c4:CONTAIN]->(s1),
  (b1)-[c5:CONTAIN]->(s2),
  (b1)-[c6:CONTAIN]->(s3),
  (b1)-[c7:CONTAIN]->(s4),
  (b1)-[c8:CONTAIN]->(s5),

  (b3)-[c9:CONTAIN]->(s9),
  (b4)-[c10:CONTAIN]->(s10),

  (a1)-[f1:FEATURE {form: "singer"}]->(s8),
  (a4)-[f2:FEATURE {form: "rapper"}]->(s9);


  // Pocet pisnicek za kazde album, serazene od nejvyssiho
  MATCH (b:ALBUM)
  WITH b, SIZE( (b)-[:CONTAIN]->(:SONG) ) AS nosongs
  RETURN b.name, nosongs
  ORDER BY nosongs DESC;

  // Vypsat pisnicky z alba "Snapping" a pokud maji, tak i feature umelce
  MATCH (b:ALBUM)-[:CONTAIN]->(s:SONG)
    WHERE b.id = "a-snapping"
  OPTIONAL MATCH (a:ARTIST)-[f:FEATURE]->(s)
  RETURN s.name, a.name,f.form;

  // Hip hop pisnicky s jejich datem vydani, serazene sestupne
  MATCH (b:ALBUM)-[:CONTAIN]->(s:SONG)
    WHERE s.genre = "Hip-Hop"
  RETURN s.name, b.release, s.genre
  ORDER BY b.release DESC;

  // Pisnicky, co spadaji pod Banana entertainment
  MATCH (a:ARTIST {company: "Banana Ent"})-[:SING]->(b:ALBUM)-[:CONTAIN]->(s:SONG)
  return a.name,a.company,s.name;

  // Kratsi contemporary pisnicky
  MATCH (s:SONG {genre: "Contemporary"})
    WHERE s.duration < 180
  RETURN *; 
