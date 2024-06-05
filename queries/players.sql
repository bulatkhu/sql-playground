drop table if exists Team;
create table Team (
    id int primary key generated always as identity,
    name varchar(255)
);
insert into team (name) values ('team1'), ('team2'), ('team3');


drop table if exists Player;
create table Player (
    id int primary key generated always as identity,
    teamId int
);
ALTER TABLE Player ADD FOREIGN KEY (teamId) REFERENCES Team(id) on DELETE CASCADE;


insert into player (teamId) values (1), (2), (3);

delete from player where id = 1;

select * from player left join player p on player.teamId = p.teamid;