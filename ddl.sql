
# 何時加 not null?
# 如果有嚴格判斷輸入，有沒有寫not null就沒什麼影響的樣子

# picture how?
# 用URL試試看

# 一扭蛋一ID? or 扭出後訂單扣除扭蛋數量
# 同種扭蛋一ID，扭出後扭蛋到訂單所以會扣扭蛋數量

# 發公告：商家.帳號、扭蛋機.ID、公告內容
# 問題反饋：扭蛋機.ID、玩家.帳號、反饋內容
# 商家：帳號、密碼、帳戶
# 扭蛋機：ID、商家帳號、名稱、價格、圖片、種類數量
# 扭蛋：ID、名稱、圖、數量、扭蛋機.ID
# 玩家：帳號、密碼、寄送地址、帳戶
# 訂單：	ID、扭蛋.ID、玩家.帳號、已寄送

#菱形是verb(像老師DDL的takes)可以跟方形區分
create table announces
(
	# foreign key會在這裡先定義
	enterprise_ID varchar(8),
	machine_ID varchar(8),
	content varchar(1000) not null,
	
	# 這樣表示一個商家對一個扭蛋機只會有一個公告，多了要用update
	primary key (enterprise_ID, machine_ID),
	foreign key (enterprise_ID) references enterprise (ID) 
		on delete cascade,
	# 如果商家或扭蛋機被刪掉，他們的公告也會刪除
	foreign key (machine_ID) references machine (ID) 
		on delete cascade
)ENGINE=INNODB;


# comment是保留字，改asks(想不到其他動詞..
create table asks
(
	player_id varchar(8),
	machine_id varchar(8),
	content varchar(1000),
	
	# 這樣表示一個玩家對一個扭蛋機只會有一個問題反饋，多了要用update
	primary key (player_ID, machine_ID),
	foreign key (player_id) references player (id) 
		on delete cascade,
	# 如果玩家或扭蛋機被刪掉，他們的問題反饋也會刪除
	foreign key (machine_ID) references machine (ID) 
		on delete cascade

)ENGINE=INNODB;

create table enterprise
(
	ID         varchar(8)  ,
	password   varchar(8)  not null  ,
	#記得在初始account設0
	account    varchar(18) not null,
	PRIMARY KEY (ID)

)ENGINE=INNODB;

create table machine
(
	ID         varchar(8)  not null,
	name       varchar(10) not null,
	price      decimal(5,0)  check (price>0),
	# 可以用URL存(再研究
	picture VARCHAR(50),
	amount     decimal(12,0) check (amount>0),
	enterprise_ID VARCHAR(8),
	primary key (ID),
	# 如果商家被刪掉，扭蛋機也會刪除
	foreign key (enterprise_ID) references enterprise (ID) 
		on delete cascade

)ENGINE=INNODB;

create table gashapon
(
	ID         varchar(8)  not null,
	name       varchar(10) not null,
	picture VARCHAR(50),
	# 扭蛋數量應該可以=0，表示扭完了
	amount     decimal(12,0) not null,
	machine_ID VARCHAR(8),
	primary key (ID),
	foreign key (machine_ID) references machine (ID) 
		on delete set null
)ENGINE=INNODB;

create table player
(
	ID         varchar(8)  ,
	password   varchar(8)  not null  ,
	account    varchar(18) not null  ,
	address    varchar(50) not null,
	PRIMARY KEY (ID)
)ENGINE=INNODB;


# ORDER是保留字，改 orderform(或其他我想不到了
create table orderform
(
	ID         varchar(8)  ,
	send       bool,
	gashapon_ID varchar(8),
	player_ID varchar(8),
	PRIMARY KEY (ID),
	# 扭蛋ID不能刪除，訂單會沒有紀錄
	# foreign key (gashapon_ID) references gashapon (ID) 
		on delete set null
	# 玩家ID刪除也會沒有訂單紀錄，不過好像可以刪?所以留著
	foreign key (player_ID) references player (ID) 
		on delete set null
)ENGINE=INNODB;
