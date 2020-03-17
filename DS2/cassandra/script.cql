CREATE TABLE artists (
  id INT, 
  name TEXT, 
  debut TUPLE<SMALLINT, TEXT, TEXT>, -- debut contains year of debut, debut company, debut song
  company TEXT,
  socialmedia MAP<TEXT, TEXT>,
  affiliations LIST<TEXT>, -- groups that this artist belongs to right now (collaborations)
  primary key (company, name)
  );

  -- indexing social networks
  CREATE INDEX artSocNetw ON artists(KEYS(socialmedia));

  INSERT INTO ARTISTS (id, name, debut, company, socialmedia, affiliations) VALUES (
  10032007,
  'Sunmi',
  (2007, 'JYP Entertainment', 'Irony'),
  'Banana Entertainment',
  {'instagram':'sunmi_official1', 'personal_ig':'miyayea', 'facebook':'Lee Sunmi Official'},
  ['Wonder Girls']
  );

  INSERT INTO ARTISTS (id, name, debut, company, socialmedia, affiliations) VALUES (
  02122013,
  'Chungha',
  (2013, 'Star Entertainment', 'Whatta Man'),
  'Star Entertainment',
  {'personal_ig':'chunghAh','facebook':'Chungha fanpage'},
  ['IOI']
  );

  INSERT INTO ARTISTS (id, name, debut, company, socialmedia, affiliations) VALUES (
  01012010,
  'Heize',
  (2010, 'Independent artist','I like'),
  'Independent',
  {'personal_ig':'heiyeheiz00'},
  ['Unpretty Rapstar']
  );

  INSERT INTO ARTISTS (id, name, debut, company, socialmedia, affiliations) VALUES (
  03042006,
  'Yubin',
  (2006, 'JYP Entertainment', 'Irony'),
  'JYP Entertainment',
  {'instagram':'yubstagram', 'facebook':'Wonderful Official'},
  ['Wonder Girls','Unpretty Rapstar']
  );

  INSERT INTO ARTISTS (id, name, debut, company, socialmedia, affiliations) VALUES (
  02102002,
  'Jessi',
  (2002,'Indi Music', 'Strong unnie'),
  'PSY Entertainment',
  {'instagram':'jessibi', 'personal_ig':'jessjess', 'facebook':'Jebbies', 'twitter':'jj1jess'},
  ['Lucky J','Unpretty Rapstar']
  );

  INSERT INTO ARTISTS (id, name, debut, company) VALUES (
  03042014,
  'Lee Chaeyeon',
  (2014, 'Banana Entertainment', 'Violetta'),
  'Banana Entertainment'
  );




CREATE TABLE albums (
  name TEXT,
  songs list<TEXT>,
  artist TEXT,
  songlength map<TEXT, TEXT>,
  genres set<TEXT>,
  primary key (artist, name)
  );

INSERT INTO ALBUMS (name, songs, artist, songlength, genres) VALUES (
  'Noir',
  ['24 hours','Full Moon','Addict'],
  'Sunmi',
  {'24 hours':'3:15', 'Full Moon':'3:12', 'Addict':'2:10'},
  {'contemporary','pop'}
  );

INSERT INTO ALBUMS (name, songs, artist, songlength, genres) VALUES (
  'Snapping',
  ['Snapping','Gotta Go','Why'],
  'Chungha',
  {'Snapping':'3:25', 'Gotta Go':'3:34', 'Why':'3:26'},
  {'pop','dance','classical'}
  );

  INSERT INTO ALBUMS (name, songs, artist, songlength, genres) VALUES (
  'July',
  ['Shut up and Groove','Rain'],
  'Heize',
  {'Shut up and Groove':'3:42', 'Rain':'3:05'},
  {'R&B','hip-hop'}
  );

  INSERT INTO ALBUMS (name, songs, artist, songlength, genres) VALUES (
  'Back',
  ['Lady','Thank you','Saekda', 'Love'],
  'Yubin',
  {'Lady':'3:12', 'Thank you':'3:17', 'Saekda':'3:20', 'Love':'3:16'},
  {'rap','city-pop', 'retro'}
  );

  INSERT INTO ALBUMS (name, songs, artist, songlength, genres) VALUES (
  'Strong unnie',
  ['Gucchi','Whos Your Mama','Who Dat B'],
  'Jessi',
  {'Gucchi':'3:32','Whos Your Mama':'3:23','Who Dat B':'3:14'},
  {'hip-hop'}
  );






-- delete map
UPDATE artists
  SET
    socialmedia = socialmedia - {'facebook'}
WHERE company = 'JYP Entertainment' AND name = 'Yubin';  

-- add list, map
UPDATE albums
  SET
    songs = songs + ['Gashina'],
    songlength = songlength + {'Gashina':'4:01'}
WHERE name='Noir' and artist='Sunmi';

-- add set
-- delete set
UPDATE albums
  SET
    genres = genres + {'hip-hop'},
    genres = genres - {'classical'}
  WHERE name='Snapping' and artist='Chungha';

-- delete list (group IOI got disbanded)
UPDATE artists
SET
  affiliations = affiliations - ['IOI']
WHERE company = 'Star Entertainment' AND name = 'Chungha';

-- replace map
UPDATE albums
SET
  songlength['Snapping'] = '3:21'
WHERE artist='Chungha' AND name='Snapping';

-- replace list, map
UPDATE artists
SET
  affiliations[0] = 'Wonder Girls, the Band',
  socialmedia['instagram'] = 'iloveyub'
WHERE company = 'JYP Entertainment' and name = 'Yubin';

-- replace tuple
UPDATE artists
SET
  DEBUT = (2007, 'JYP Entertainment', 'Nobody')
WHERE company = 'Banana Entertainment' AND name = 'Sunmi';

-- replace set
UPDATE albums
SET
  genres = {'hip-hop','retro-pop', 'EDM'}
WHERE artist='Yubin' AND name='Back';


--SELECT QUERIES
-- get all the hip-hop albums
SELECT *
FROM albums
WHERE genres CONTAINS 'hip-hop'
ALLOW FILTERING;

-- get all artists of Banana Entertainment, sorted alphabetically
SELECT name FROM artists
WHERE company = 'Banana Entertainment'
ORDER BY name;

-- get all artists that are present on Facebook
SELECT name from artists
WHERE socialmedia CONTAINS KEY 'facebook';