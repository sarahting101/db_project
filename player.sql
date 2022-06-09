/* 註冊 */
/*玩家不需輸入ID和money，系統會給*/
insert into `player` (`password`, `account`, `money`,`address`) values('玩家輸入的密碼', '玩家輸入的帳戶', 200/*看要預設多少*/, '玩家輸入的地址');

/* 登入 */
select * 
from `player`
where `player_id` = '玩家輸入的ID' and `password` = '玩家輸入的password';

/* 查看個人帳戶資料 */
	/*帳號、密碼、寄送地址、帳戶、帳戶金幣餘額*/
	select `player_id`, `password`, `address`, `account`, `money`
	from `player`
	where `player_id` = '玩家ID';
	/*未寄送(send = 0)的訂單編號、扭蛋*/
	select `orderform_id`, `gashapon_id`
	from `player` join `orderform` using(player_id)
	where `player_id` = '玩家ID' and send = 0;
	/*申請寄送(send = 1)的訂單編號、扭蛋*/
	select `orderform_id`, `gashapon_id`
	from `player` join `orderform` using(player_id)
	where `player_id` = '玩家ID' and send = 1;
	/*歷史訂單: 已寄送(send = 2)的訂單編號、扭蛋*/
	select `orderform_id`, `gashapon_id`
	from `player` join `orderform` using(player_id)
	where `player_id` = '玩家ID' and send = 2;

	/*各種update*/
		/* 更改密碼 */
		update `player`
		set `password` = '玩家新輸入的密碼'
		where `player_id` = '玩家ID';
		/* 更改地址 */
		update `player`
		set `address` = '玩家新輸入的地址'
		where `player_id` = '玩家ID';
		/* 儲值金幣 */
		update `player`
		set `money` = `money` + '儲值的金額'
		where	`player_id` = '玩家ID';

/*玩家進行扭蛋*/
	/* 列出所有扭蛋機 */
	/* 扭蛋機名稱、扭蛋機金額、扭蛋機圖片、扭蛋機裡面有幾個種類的扭蛋、扭蛋總個數 */
	select `machine`.`name`, `price`, `machine`.`picture`, `machine`.`amount`, sum(`gashapon`.`amount`)
	from `machine` join `gashapon` using(machine_id)
	group by `machine_id`
	having sum(`gashapon`.`amount`)>0;/* 扭蛋個數要大於0才會列出 */

	/*需要先存玩家扭蛋前的金幣餘額*/
	select `money`
	from `player`
	where `player_id` = '玩家ID';

	/* 選擇一個扭蛋機後先付錢 */		
	update `player`
	set `money` = 
	(select case 
			when `money` >= `price`
			then `money` - `price`
			else `money` end
			from `machine`
			where `machine_id` = '玩家選擇的扭蛋機ID')
	where `player_id` = '玩家ID';

	/* 讀取扣款後的金幣餘額 */			
	select `money`
	from `player`
	where `player_id` = '玩家ID';
	/*
	和扭蛋前暫存的金幣餘額相比，判斷金額是否相同
	(相同表示金額不夠，無法扣款 --> 結束)
	*/	
	/* 成功扣款後*/
		 /*隨機選一顆扭蛋給玩家*/
		select `gashapon_id` 
		from `gashapon` as T
		where T.`machine_id` = '玩家選擇的扭蛋機ID' and T.`amount`>0
		order by rand()
		limit 1;

		/*該扭蛋個數減一 */
		update `gashapon`
		set `amount` = `amount` - 1
		where `gashapon_id` = '玩家扭到的扭蛋ID(上一步的結果)';  

		/*建立訂單*/
		INSERT INTO `orderform` (`send`, `gashapon_id`, `player_id`) VALUES
		(0, '玩家扭到的扭蛋ID', '玩家ID');

		/*申請訂單*/
		update `orderform`
		set `send` = 1
		where `orderform_id` = '寄出的訂單ID';

	
/* 反饋問題給該扭蛋機商家 */
INSERT INTO `asks` (`player_id`, `machine_id`, `content`) VALUES
('玩家ID', '扭蛋機ID', '反饋內容');