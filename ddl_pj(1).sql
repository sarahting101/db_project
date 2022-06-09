CREATE DATABASE IF NOT EXISTS `db_project`;
use `db_project`;

/* 
	ID 編號開頭(最高位)
	1: enterprise
	2: player
	3: machine
	4: gashapon
	5: orderform
*/

CREATE TABLE IF NOT EXISTS `enterprise`
(
	`enterprise_id`   int         NOT NULL AUTO_INCREMENT,
	`password`        varchar(8)  not null,
	`account`         varchar(18) not null,
	`money`		      decimal(12,0) not null,

	primary key (`enterprise_id`)

)ENGINE=INNODB AUTO_INCREMENT = 10001;

CREATE TABLE IF NOT EXISTS `machine`
(
	`machine_id`      int         NOT NULL AUTO_INCREMENT,
	`name`            varchar(10) not null,
	`price`           decimal(5,0)  check (price>0),
	/* 圖片用URL存(?? */
	`picture`         VARCHAR(50),
	`amount`          decimal(12,0) check (amount>0),
	`enterprise_ID`   int,
	primary key (`machine_id`),
	foreign key (`enterprise_ID`) references enterprise (enterprise_id) 
		on delete cascade

)ENGINE=INNODB AUTO_INCREMENT = 30001;

CREATE TABLE IF NOT EXISTS `announces`
(
	`enterprise_id`   int,
	`machine_id`      int,
	`content`         varchar(1000) not null,

	primary key (`enterprise_id`, `machine_id`),
	foreign key (`enterprise_id`) references `enterprise` (enterprise_id) 
		on delete cascade,
	foreign key (`machine_id`) references machine (machine_id) 
		on delete cascade
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `player`
(
	`player_id`       int         NOT NULL AUTO_INCREMENT,
	`password`        varchar(8)  not null,
	`account`         varchar(18) not null,
	`money`           decimal(12,0),
	`address`         varchar(50) not null,
	primary key (`player_id`)
)ENGINE=INNODB AUTO_INCREMENT = 20001;

CREATE TABLE IF NOT EXISTS `asks`
(
	`player_id`       int,
	`machine_id`      int,
	`content`         varchar(1000),
	
	primary key (`player_id`, `machine_ID`),
	foreign key (`player_id`) references player (player_id) 
		on delete cascade,
	foreign key (`machine_id`) references machine (machine_id) 
		on delete cascade

)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `gashapon`
(
	`gashapon_id`     int         NOT NULL AUTO_INCREMENT,
	`name`            varchar(10) not null,
	`picture`         varchar(50),
	`amount`          decimal(12,0) not null,
	`machine_id`      int,
	primary key (`gashapon_id`),
	foreign key (`machine_id`) references machine (machine_id) 
		on delete set null
)ENGINE=INNODB AUTO_INCREMENT = 40001;

CREATE TABLE IF NOT EXISTS `orderform`
(
	`orderform_id`    int         NOT NULL AUTO_INCREMENT,
	`send`            bool,
	`gashapon_id`     int,
	`player_id`       int,
	primary key (`orderform_id`),
	foreign key (`player_id`) references player (player_id) 
		on delete set null
)ENGINE=INNODB AUTO_INCREMENT = 50001;


/* 
	ID編號開頭(最高位)
	1: enterprise
	2: player
	3: machine
	4: gashapon
	5: orderform
*/
delete from `enterprise`;
delete from `machine`;
delete from `announces`;
delete from `player`;
delete from `asks`;
delete from `gashapon`;
delete from `orderform`;


INSERT INTO `enterprise` (`enterprise_id`, `password`, `account`, `money`) VALUES
	(10001, '12345', '1234510001', 0),
	(10002, '12345', '1234510002', 0),
	(10003, '12345', '1234510003', 0),
	(10004, '12345', '1234510004', 0),
	(10005, '12345', '1234510005', 0);
	
INSERT INTO `machine` (	`machine_id`, `name`, `price`, `picture`, `amount`, `enterprise_id`) VALUES
	/* 圖片再研究q */
	(30001, 'animal', 60, 'https://i.imgur.com/CNSpmqF.png', 3, 10001),
	(30002, 'fruit', 70, 'https://i.imgur.com/CNSpmqF.png', 3, 10002),
	(30003, 'sport', 80, 'https://i.imgur.com/CNSpmqF.png', 3, 10003);
	
INSERT INTO `announces` (`enterprise_id`, `machine_id`, `content`) VALUES
	(10001, 30001, 'on sale'),
	(10002, 30002, 'hot sale'),
	(10003, 30003, 'new!!');
	
INSERT INTO `player` (`player_id`, `password`, `account`, `money`, `address`) VALUES
	(20001, '67890', '6789020001', 500, '台北市文山區汀州路四段88號'),
	(20002, '67890', '6789020002', 500, '台北市大安區和平東路一段162號'),
	(20003, '67890', '6789020003', 500, '台北市大安區和平東路一段129號');
	
INSERT INTO `asks` (`player_id`, `machine_id`, `content`) VALUES
	(20001, 30003, 'balabala'),
	(20002, 30002, 'balabala'),
	(20003, 30001, 'balabala');
	
INSERT INTO `gashapon` (`gashapon_id`, `name`, `picture`, `amount`, `machine_id`) VALUES
	/* 圖片再研究q */
	(40001, 'cat', 'https://i.imgur.com/CNSpmqF.png', 4, 30001),
	(40002, 'dog', 'https://i.imgur.com/CNSpmqF.png', 5, 30001),
	(40003, 'rabbit', 'https://i.imgur.com/CNSpmqF.png', 5, 30001),
	(40004, 'apple', 'https://i.imgur.com/CNSpmqF.png', 4, 30002),
	(40005, 'mango', 'https://i.imgur.com/CNSpmqF.png', 5, 30002),
	(40006, 'melon', 'https://i.imgur.com/CNSpmqF.png', 5, 30002),
	(40007, 'soccer', 'https://i.imgur.com/CNSpmqF.png', 5, 30003),
	(40008, 'baseball', 'https://i.imgur.com/CNSpmqF.png', 4, 30003),
	(40009, 'tennis', 'https://i.imgur.com/CNSpmqF.png', 5, 30003);
	
INSERT INTO `orderform` (`orderform_id`, `send`, `gashapon_id`, `player_id`) VALUES
/* 0: 未寄出, 1:已寄出 */
	(50001, 0, 40001, 20001),
	(50002, 0, 40004, 20002),
	(50003, 1, 40008, 20003);



