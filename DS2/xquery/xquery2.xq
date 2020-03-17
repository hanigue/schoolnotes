(:Jmena umelcu, kteri zpivaji pouze jednim jazykem:)

for $artist in //artists/artist
let $song:=//album[@artistid=$artist/@id]//song
let $firstsonglanguage:=$song[1]/language/text()
where (every $lang in $song/language/text() satisfies $lang=$firstsonglanguage) and count($song)>0
return $artist/data(name)