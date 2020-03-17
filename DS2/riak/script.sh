#!/bin/bash

# There are optional all-key GETs to check if something is present in the bucket whenever I'm finished with adding objects to a certain category.
# Uncomment for quick check if needed.

# ADD SONGS TO BUCKET: -------------------------------------------------------------------------------
echo "Adding song Gotta Go ..."
# ADD SONG GOTTA GO
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Gotta Go", "year" : 2014, "time" : "3:14" }' http://localhost:10011/buckets/$1_songs/keys/gottago

echo "Adding song Snapping ..."
# ADD SONG SNAPPING
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Snapping", "year" : 2016, "time" : "3:12" }' http://localhost:10011/buckets/$1_songs/keys/snapping

echo "Adding song Gashina ..."
# ADD SONG GASHINA
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Gashina", "year" : 2016, "time" : "3:23" }' http://localhost:10011/buckets/$1_songs/keys/gashina

echo "Adding song Siren ..."
# ADD SONG SIREN
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Siren", "year" : 2016, "time" : "3:24" }' http://localhost:10011/buckets/$1_songs/keys/siren

echo "Adding song Groove ..."
# ADD SONG Groove
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Groove", "year" : 2018, "time" : "3:04" }' http://localhost:10011/buckets/$1_songs/keys/groove

echo "Adding song Akmu ..."
# ADD SONG AKMU
curl -i -X PUT -H 'Content-Type: application/json' -d '{ "name" : "Akmu", "year" : 2017, "time" : "4:01" }' http://localhost:10011/buckets/$1_songs/keys/akmu

# GET all songs added so far
# curl -X GET http://localhost:10011/buckets/$1_songs/keys?keys=true

# ADD LINK SONG - ALBUM -------------------------------------------------------------------------------

echo "Adding link between song Gotta go and album Roller Coaster ... "
# Gotta Go - Roller coaster
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_songs/keys/gottago>; riaktag="tsong"' -d '{ "name" : "Roller Coaster", "year" : 2014, "number of songs" : 7 }' http://localhost:10011/buckets/$1_albums/keys/rollercoaster

echo "Adding link between songs Gashina, Siren and album Noir ... "
# Gashina, Siren - Noir
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_songs/keys/gashina>; riaktag="tsong"' -H 'Link: </buckets/'"$1"'_songs/keys/siren>; riaktag="tsong"' -d '{ "name" : "Noir", "year" : 2016, "number of songs" : 6 }' http://localhost:10011/buckets/$1_albums/keys/noir

echo "Adding link between song Groove and album July ... "
# Groove - July
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_songs/keys/groove>; riaktag="tsong"' -d '{ "name" : "July", "year" : 2018, "number of songs" : 4 }' http://localhost:10011/buckets/$1_albums/keys/july 

echo "Adding link between song Akmu and album Cider ... "
# Akmu - Cider
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_songs/keys/akmu>; riaktag="tsong"' -d '{ "name" : "Cider", "year" : 2017, "number of songs" : 7 }' http://localhost:10011/buckets/$1_albums/keys/cider

echo "Adding link between song Snapping and album Snapping ... "
# Snapping - Snapping
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_songs/keys/snapping>; riaktag="tsong"' -d '{ "name" : "Snapping", "year" : 2016, "number of songs" : 8 }' http://localhost:10011/buckets/$1_albums/keys/snapping

# GET all albums added so far
# curl -X GET http://localhost:10011/buckets/$1_albums/keys?keys=true

# ADD LINK ARTIST-ALBUM -------------------------------------------------------------------------------

echo "Adding link between artist Chungha and albums Roller Coaster, Snapping ... "
# Chungha - Roller Coaster, Snapping
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link : </buckets/'"$1"'_albums/keys/snapping>; riaktag="talbum"' -H 'Link: </buckets/'"$1"'_albums/keys/rollercoaster>; riaktag="talbum"' -d '{ "name" : "Chungha", "debut" : 2013, "agency" : "WM entertainment" }' http://localhost:10011/buckets/$1_artists/keys/chungha

echo "Adding link between artist Sunmi and album Noir ... "
# Sunmi - Noir
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_albums/keys/noir>; riaktag="talbum"' -d '{ "name" : "Sunmi", "debut" : 2007, "agency" : "Banana entertainment" }' http://localhost:10011/buckets/$1_artists/keys/sunmi

echo "Adding link between artist Heize and album July ... "
# Heize - July
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_albums/keys/july>; riaktag="talbum"' -d '{ "name" : "Heize", "debut" : 2012, "agency" : "Hello entertainment" }' http://localhost:10011/buckets/$1_artists/keys/heize

echo "Adding link between artist Yezi and album Cider ... "
# Yezi - Cider
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_albums/keys/cider>; riaktag="talbum"' -d '{ "name" : "Yezi", "debut" : 2003, "agency" : "Star entertainment" }' http://localhost:10011/buckets/$1_artists/keys/yezi 

# GET all artists added so far
# curl -X GET http://localhost:10011/buckets/$1_artists/keys?keys=true
#-------------------------------------------------------------------------------

echo "UPDATE ARTIST YEZI'S DEBUT TO 2013 ... "
# UPDATE of artist Yezi's debut to 2013 instead of 2003 ------------------------
curl -i -X PUT -H 'Content-Type: application/json' -H 'Link: </buckets/'"$1"'_albums/keys/cider>; riaktag="talbum"' -d '{ "name" : "Yezi", "debut" : 2013, "agency" : "Star entertainment" }' http://localhost:10011/buckets/$1_artists/keys/yezi

echo "READ IF THE UPDATE HAS BEEN DONE ... "
# READ if the update has been done ---------------------------------------------
curl -i -X GET http://localhost:10011/buckets/$1_artists/keys/yezi

echo "GET SONGS FROM CHUNGHA (all albums) ... "
# GET all songs from artist Chungha --------------------------------------------
curl -i -X GET http://localhost:10011/buckets/$1_artists/keys/chungha/$1_albums,talbum,0/$1_songs,tsong,1

echo "GET ALL SONGS FROM ALBUM NOIR ... "
# GET all songs from album Noir ------------------------------------------------
curl -i -X GET http://localhost:10011/buckets/$1_albums/keys/noir/$1_songs,tsong,1

echo "EMPTY EVERYTHING ... "
# DELETE all data --------------------------------------------------------------
curl -i -X DELETE http://localhost:10011/buckets/$1_artists/keys/chungha

curl -i -X DELETE http://localhost:10011/buckets/$1_artists/keys/sunmi

curl -i -X DELETE http://localhost:10011/buckets/$1_artists/keys/heize

curl -i -X DELETE http://localhost:10011/buckets/$1_artists/keys/yezi

curl -i -X DELETE http://localhost:10011/buckets/$1_albums/keys/rollercoaster

curl -i -X DELETE http://localhost:10011/buckets/$1_albums/keys/snapping

curl -i -X DELETE http://localhost:10011/buckets/$1_albums/keys/noir

curl -i -X DELETE http://localhost:10011/buckets/$1_albums/keys/july

curl -i -X DELETE http://localhost:10011/buckets/$1_albums/keys/cider

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/gottago

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/snapping

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/gashina

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/siren

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/groove

curl -i -X DELETE http://localhost:10011/buckets/$1_songs/keys/akmu
