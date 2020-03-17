POPIS DATOVÉ STRUKTURY
-----------------------
Data:
Sunmi;24 hours;contemporary,pop;3:15;producers;Sunmi/Yubin/Yeeun;lyrics;Sunmi/Yubin 
koresponduji se strukturou:
Artist;song;genre,genre,...;time;producers;producer-name/producer-name/...;lyrics;writer/writer/...

POPIS MAPREDUCE:
------------------------
MapReduce:
Úkolem je spočítat, z kolika procent si autoři produkují hudbu nebo píší texty.
Mapper pošle pod klíčem "artist" dvě boolean hodnoty, které říkají, 
zda se umělec vyskytuje v "producer" a "lyrics" u své písničky. 
Reducer pak tyto údaje zagreguje a spočítá procenta. 


Pro pouziti Mr.Script se staci mit vsechny files ve stejny slozce, pustit ho s argumentama <username> <jmeno tvyho java souboru>. It's quite convenient.