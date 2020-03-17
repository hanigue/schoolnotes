(:Tabulka s prumerem pisnicek za album:)

<table>
<tr>
<th>Artist</th> <th>Average per album</th> </tr>
{
 for $artist in //artists/artist
    let $album:= //album[@artistid=$artist/@id]
    let $noalbum:=count($album)
 order by $artist ascending
return
<tr>
<td>{$artist/name/text()}</td>
<td>{if($noalbum=0) then("No song yet") else(count($album//song) div $noalbum)}</td>
</tr>
}
</table>