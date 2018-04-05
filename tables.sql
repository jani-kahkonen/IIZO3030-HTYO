-- -----------------------------------------------------
-- Table customer (fname, lname)
-- -----------------------------------------------------
CREATE TABLE customer
(
	id INT NOT NULL AUTO_INCREMENT,
	fname VARCHAR(64) NOT NULL,
	lname VARCHAR(64) NOT NULL,
	PRIMARY KEY (id)
);
-- -----------------------------------------------------
-- Table account (email, pword)
-- -----------------------------------------------------
CREATE TABLE account
(
	id INT NOT NULL AUTO_INCREMENT,
	email VARCHAR(64) NOT NULL,
	pword VARCHAR(64) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT uq_account_email UNIQUE (email)
);
-- -----------------------------------------------------
-- Table subscription (customer_id, sdate, edate)
-- -----------------------------------------------------
CREATE TABLE subscription
(
	id INT NOT NULL AUTO_INCREMENT,
	customer_id INT NOT NULL,
	sdate DATETIME NOT NULL,
	edate DATETIME NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_subscription_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id)
);
-- -----------------------------------------------------
-- Table account_subscription (subscription_id, account_id, price)
-- -----------------------------------------------------
CREATE TABLE account_subscription
(
	id INT NOT NULL AUTO_INCREMENT,
	subscription_id INT NOT NULL,
	account_id INT NOT NULL,
	price DECIMAL(4, 2) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_account_subscription_subscription_id FOREIGN KEY (subscription_id) REFERENCES subscription (id),
	CONSTRAINT fk_account_subscription_account_id FOREIGN KEY (account_id) REFERENCES account (id)
);
-- -----------------------------------------------------
-- Table character (PIVOT)
-- -----------------------------------------------------
CREATE TABLE player
(
	id INT NOT NULL AUTO_INCREMENT,
	account_id INT NOT NULL,
	property_name VARCHAR(32) DEFAULT NULL,
	value VARCHAR(32) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT uq_player_pname UNIQUE (value),
	CONSTRAINT fk_player_account_id FOREIGN KEY (account_id) REFERENCES account (id)
);