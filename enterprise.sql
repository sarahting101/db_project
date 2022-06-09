//註冊
insert into `enterprise` (`password`, `account`, `money`) values
	('密碼', '帳戶', 0);

//查看帳戶資料
	//帳號、密碼帳戶、帳戶金幣餘額
	SELECT *
	FROM enterprise
	WHERE enterprise_id= 查看的商家id;

	//查看帳戶金幣餘額
	SELECT money
	FROM enterprise
	WHERE enterprise_id= 查看的商家id;

//查看扭蛋機
SELECT machine_id, name, price, picture, amount
FROM machine
WHERE machine_id= 查看的扭蛋機id;

	//查看扭蛋機剩餘扭蛋"種類"數量
	SELECT amount
	FROM machine
	WHERE machine_id= 查看的扭蛋機id;

	//查看剩餘"扭蛋"
	SELECT name, picture, amount
	FROM gashpon NATURAL JOIN machine
	WHERE machine_id= 查看的扭蛋機id;

	//新增舊扭蛋
	UPDATE gashpon
	SET amount= 新的扭蛋數量
	WHERE gashpon_id= 扭蛋id;

	//新增新扭蛋
	INSERT INTO `gashapon` (`name`, `picture`, `amount`, `machine_ID`) 
		VALUES('名字', '圖片', 數量 , '扭蛋機id');

		/*CREATE TRIGGER gashpon_amount_change AFTER INSERT ON gashpon
		REFERENCING NEW ROW AS nrow
		FOR EACH ROW
			UPDATE machine 
			SET amount++;
			WHERE machine.machine_ID=nrow.machine_ID
		END;*/

//查看玩家的問題反饋
	//單一扭蛋機問題反饋
	SELECT player_id, content
	FROM asks 
	WHERE machine_id= 查看的扭蛋機id;

	//所有扭蛋機問題反饋
	SELECT player_id, content
	FROM asks 
	WHERE machine_id= (SELECT machine_id
					   FROM enterprise
					   WHERE enterprise_id= 扭蛋機id);
//所有已售出商品
SELECT gashapon.name, count(*)
FROM gashapon NATURAL JOIN orderform
GROUP BY gashapon.name;

	//檢視未寄送商品
	SELECT gashapon.name, count(*)
	FROM gashapon NATURAL JOIN orderform
	WHERE orderform.send=0 or orderform.send=1
	GROUP BY gashapon.name;
	
	//檢視申請寄送商品
	SELECT gashapon.name, gashapon.player_id, count(*)
	FROM gashapon NATURAL JOIN orderform
	WHERE orderform.send=1
	GROUP BY gashapon.name;

	//檢視已寄送商品
	SELECT gashapon.name, gashapon.player_id, count(*)
	FROM gashapon NATURAL JOIN orderform
	WHERE orderform.send=2
	GROUP BY gashapon.name;


//未寄送->已寄送
UPDATE orderform
SET send = 2
WHERE orderform_id=

//確認玩家寄件地址
SELECT player_id, address
FROM player
WHERE player_id=玩家id


//發送公告(一機器一公告)
INSERT INTO `announces` (`enterprise_id`, `machine_id`, `content`) VALUES
	(商家id, 扭蛋機id, '內容');

//更改公告(一機器一公告)
UPDATE announces
SET content='新內容'
WHERE enterprise_id=商家id AND machine_id=扭蛋機id;

