-- Frage 4;
select count(*) from "track"; -- 3503
-- Make sure all tracks counted correctly
select * from "track" order by track.track_id desc;

-- Frage 5;
select count(*) as quantity from  "track" where milliseconds < 10000; -- 5

-- Frage 6:
select * from "artist" where name ILIKE 'Santana%';
select count(*) as Santanas from "artist" where name ILIKE 'Santana%';

-- Frage 7;
select * from track where composer = 'Chris Cornell' or composer = 'Kurt Cobain'; -- 49
select * from track where track_id = 2512; -- should be counted
select * from track where composer ILIKE '%Chris Cornell%' and composer not LIKE 'Chris Cornell'; -- should not be counted: 20

-- Frage 8;
select artist.name
from album
inner join artist on artist.artist_id = album.artist_id
where album.title = 'Ten';

-- Frage 9:
select count(*) from track
inner join album on track.album_id = album.album_id
inner join artist on album.artist_id = artist.artist_id
where artist.name = 'Green Day';
-- 34