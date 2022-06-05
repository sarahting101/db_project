CREATE DATABASE IF NOT EXISTS `db_project`;
use `db_project`;

create table `enterprise`
(
	`ID`         varchar(8),
	`password`   varchar(8)  not null,
	`account`    varchar(18) not null,
	primary key (`ID`)

)ENGINE=INNODB;

create table `machine`
(
	`ID`         varchar(8)  not null,
	`name`       varchar(10) not null,
	`price`      decimal(5,0)  check (price>0),
	# 圖片用URL存
	`picture` VARCHAR(50),
	`amount`     decimal(12,0) check (amount>0),
	`enterprise_ID` varchar(8),
	primary key (`ID`),
	foreign key (`enterprise_ID`) references enterprise (ID) 
		on delete cascade

)ENGINE=INNODB;

create table `announces`
(
	`enterprise_ID` varchar(8),
	`machine_ID` varchar(8),
	`content` varchar(1000) not null,

	primary key (`enterprise_ID`, `machine_ID`),
	foreign key (`enterprise_ID`) references `enterprise` (ID) 
		on delete cascade,
	foreign key (`machine_ID`) references machine (ID) 
		on delete cascade
)ENGINE=INNODB;

create table `player`
(
	`ID`         varchar(8),
	`password`   varchar(8)  not null,
	`account`    varchar(18) not null,
	`address`    varchar(50) not null,
	primary key (`ID`)
)ENGINE=INNODB;

create table `asks`
(
	`player_id` varchar(8),
	`machine_id` varchar(8),
	`content` varchar(1000),
	
	primary key (`player_ID`, `machine_ID`),
	foreign key (`player_id`) references player (id) 
		on delete cascade,
	foreign key (`machine_ID`) references machine (ID) 
		on delete cascade

)ENGINE=INNODB;

create table `gashapon`
(
	`ID`         varchar(8)  not null,
	`name`       varchar(10) not null,
	`picture` varchar(50),
	`amount`     decimal(12,0) not null,
	`machine_ID` varchar(8),
	primary key (`ID`),
	foreign key (`machine_ID`) references machine (ID) 
		on delete set null
)ENGINE=INNODB;

create table `orderform`
(
	`ID`         varchar(8),
	`send`       bool,
	`gashapon_ID` varchar(8),
	`player_ID` varchar(8),
	primary key (`ID`),
	foreign key (`player_ID`) references player (ID) 
		on delete set null
)ENGINE=INNODB;
