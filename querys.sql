-- -----------------------------------------------------
-- Inserts
-- -----------------------------------------------------
INSERT INTO customer (fname, lname) VALUES ('customer_1_fname','customer_1_lname');
INSERT INTO account (email, pword) VALUES ('customer_1_email','customer_1_pword');
INSERT INTO subscription (customer_id, sdate, edate) VALUES (1, '2016-03-24', '2016-04-24');
INSERT INTO account_subscription (subscription_id, account_id, price) VALUES (1, 1, 39.95);
INSERT INTO player (account_id, property_name, value) VALUES (1, 'player_name', 'Customer_1_player_1');

INSERT INTO customer (fname, lname) VALUES ('customer_2_fname','customer_2_lname');
INSERT INTO account (email, pword) VALUES ('customer_2_email','customer_2_pword');
INSERT INTO subscription (customer_id, sdate, edate) VALUES (2, '2016-03-24', '2016-04-24');
INSERT INTO account_subscription (subscription_id, account_id, price) VALUES (2, 2, 39.95);
INSERT INTO player (account_id, property_name, value) VALUES (2, 'player_name', 'Customer_2_player_1');
INSERT INTO player (account_id, property_name, value) VALUES (2, 'player_name', 'Customer_2_player_2');

INSERT INTO customer (fname, lname) VALUES ('customer_3_fname','customer_3_lname');
INSERT INTO account (email, pword) VALUES ('customer_3_email','customer_3_pword');
INSERT INTO subscription (customer_id, sdate, edate) VALUES (3, '2016-04-25', '2016-05-25');
INSERT INTO account_subscription (subscription_id, account_id, price) VALUES (3, 3, 39.95);
INSERT INTO player (account_id, property_name, value) VALUES (3, 'player_name', 'Customer_3_player_1');

INSERT INTO customer (fname, lname) VALUES ('customer_4_fname','customer_4_lname');
INSERT INTO account (email, pword) VALUES ('customer_4_email','customer_4_pword');
INSERT INTO subscription (customer_id, sdate, edate) VALUES (4, '2016-04-25', '2016-05-25');
INSERT INTO account_subscription (subscription_id, account_id, price) VALUES (4, 4, 39.95);
INSERT INTO player (account_id, property_name, value) VALUES (4, 'player_name', 'Customer_4_player_1');
INSERT INTO player (account_id, property_name, value) VALUES (4, 'player_name', 'Customer_4_player_2');

INSERT INTO customer (fname, lname) VALUES ('customer_5_fname','customer_5_lname');
INSERT INTO account (email, pword) VALUES ('customer_5_email','customer_5_pword');
INSERT INTO subscription (customer_id, sdate, edate) VALUES (5, '2016-03-25', '2016-05-25');
INSERT INTO account_subscription (subscription_id, account_id, price) VALUES (5, 5, 39.95);
INSERT INTO player (account_id, property_name, value) VALUES (5, 'player_name', 'Customer_5_player_1');
INSERT INTO player (account_id, property_name, value) VALUES (5, 'player_name', 'Customer_5_player_2');
INSERT INTO player (account_id, property_name, value) VALUES (5, 'player_name', 'Customer_5_player_3');

-- -----------------------------------------------------
-- 1. Players
-- -----------------------------------------------------
SELECT * FROM player;
-- -----------------------------------------------------
-- 2. Players and accounts
-- -----------------------------------------------------
SELECT email, player.property_name, player.value FROM account
INNER JOIN player ON player.account_id = account.id
ORDER BY email;
-- -----------------------------------------------------
-- 3. Accounts and player count
-- -----------------------------------------------------
SELECT email, COUNT(*) FROM account
INNER JOIN player ON player.account_id = account.id
GROUP BY email;
-- -----------------------------------------------------
-- 4. Accounts
-- -----------------------------------------------------
SELECT * FROM account;
-- -----------------------------------------------------
-- 5. Accounts and expiration dates.
-- -----------------------------------------------------
SELECT account.email, subscription.edate FROM account_subscription
INNER JOIN account ON account.id = subscription_id
INNER JOIN subscription ON subscription.id = subscription_id
ORDER BY email;
-- -----------------------------------------------------
-- 6. Active accounts
-- -----------------------------------------------------
SELECT account.email, subscription.edate FROM account_subscription
INNER JOIN account ON account.id = subscription_id
INNER JOIN subscription ON subscription.id = subscription_id
WHERE edate >= NOW();
-- -----------------------------------------------------
-- 7. Account subscription count
-- -----------------------------------------------------
SELECT price, COUNT(*) FROM account_subscription
GROUP BY price;
-- -----------------------------------------------------
-- 8. Update price
-- -----------------------------------------------------
UPDATE account_subscription SET price=5 WHERE id=1;
-- -----------------------------------------------------
-- 1. MySQL "Pivot" player id + player name.
-- -----------------------------------------------------
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('MAX(IF(property_name = ''', property_name, ''', value, NULL)) AS ', property_name)
  ) INTO @sql
  
FROM player;
SET @sql = CONCAT('SELECT id, account_id, ', @sql, ' FROM player GROUP BY account_id');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
-- -----------------------------------------------------
-- 2. MySQL "Pivot" account email + player name. (JOIN)
-- -----------------------------------------------------
SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('MAX(IF(property_name = ''', property_name, ''', value, NULL)) AS ', property_name)
  ) INTO @sql
  
FROM player;
SET @sql = CONCAT('SELECT player.id, email, ', @sql, ' FROM account
	INNER JOIN player ON player.account_id = account.id
	GROUP BY account_id');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;