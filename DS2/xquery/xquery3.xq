(:Umelcum prisoudit jejich zanry podle zanru pisnicek:)

for $artist in //artists/artist
let $artistsong:=//album[@artistid=$artist/@id]//song/genre 
return
element artist {
  element name {text{$artist/name}},
  element genre{
  if(not($artistsong)) then("This artist has no songs yet.") else(string-join(distinct-values($artistsong), ", "))}
}