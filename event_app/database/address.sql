CREATE TABLE `address` (
	`addressid` BINARY(16) PRIMARY KEY,
	`streetnumber` VARCHAR(10) NOT NULL,
	`streetname` VARCHAR(50) NOT NULL,
	`city` VARCHAR(50) NOT NULL,
	`province` VARCHAR(50) NOT NULL,
	`country` VARCHAR(50) NOT NULL,
	`postalcode` VARCHAR(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '10', 'Street1', 'Montreal', 'Quebec', 'Canada', 'H1B6A1');
INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '11', 'Street2', 'Laval', 'Quebec', 'Canada', 'H2A1H4');
INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '12', 'Street3', 'Brossard', 'Quebec', 'Canada', 'H1U8A6');
INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '13', 'Street4', 'Longueuil', 'Quebec', 'Canada', 'H5H1A1');
INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '14', 'Street5', 'Lachine', 'Quebec', 'Canada', 'H1A1D5');
INSERT INTO address VALUES (UNHEX(REPLACE(UUID(),'-','')), '15', 'Street6', 'Montreal', 'Quebec', 'Canada', 'H1C4A1');