
何時加 not null?
picture how?
一扭蛋一ID? or 扭出後訂單扣除扭蛋數量

發公告：商家.帳號、扭蛋機.ID、公告內容

問題反饋：扭蛋機.ID、玩家.帳號、反饋內容

商家：帳號、密碼、帳戶
扭蛋機：ID、商家帳號、名稱、價格、圖片、種類數量
扭蛋：ID、名稱、圖、數量、扭蛋機.ID

玩家：帳號、密碼、寄送地址、帳戶

訂單：	ID、扭蛋.ID、玩家.帳號、已寄送



create table announcement
(
	content   varchar(1000) not null,

	foreign key (enterprise_ID) references enterprise (ID) 
		on delete set null,

	foreign key (machine_ID) references machine (ID) 
		on delete set null

)ENGINE=INNODB;

create table comment
(
	content   varchar(1000),

	foreign key (player_ID) references player (ID) 
		on delete set null,

	foreign key (machine_ID) references machine (ID) 
		on delete set null

)ENGINE=INNODB;

creata table enterprise
(
	ID         varchar(8)  ,
	password   varchar(8)  not null  ,
	account    varchar(18) not null

)ENGINE=INNODB;

creata table machine
(
	ID         varchar(8)  not null,
	name       varchar(10) not null,
	price      decimal(5,0)  check (price>0),
	amount     decimal(12,0) check (amount>0),
	foreign key (enterprise_ID) references enterprise (ID) 
		on delete set null

)ENGINE=INNODB;

creata table gashapon
(
	ID         varchar(8)  not null,
	name       varchar(10) not null,
	amount     decimal(12,0) check (amount>0),
	foreign key (machine_ID) references machine (ID) 
		on delete set null
)ENGINE=INNODB;

creata table player
(
	ID         varchar(8)  ,
	password   varchar(8)  not null  ,
	account    varchar(18) not null  ,
	address    varchar(50) not null
)ENGINE=INNODB;

creata table order
(
	ID         varchar(8)  ,
	send       bool,
	foreign key (gashapon_ID) references gashapon (ID) 
		on delete set null
	foreign key (player_ID) references player (ID) 
		on delete set null
)ENGINE=INNODB;