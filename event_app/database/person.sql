CREATE TABLE `person` (
	`personid` BINARY(16) PRIMARY KEY,
	`phone` VARCHAR(10) NOT NULL,
	`isdriver` BIT NOT NULL,
	`addressid` BINARY(16) NOT NULL,
	`userid` BINARY(16) NOT NULL,
	CONSTRAINT `person_address_addressid` FOREIGN KEY (`addressid`) REFERENCES `address` (`addressid`),
	CONSTRAINT `person_users_userid` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5141234567', 1, 0x5f47afad401411ecbe130cc47ad3b416, 0x299a117e2dbb11ec97710cc47ad3b416);
INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5141123445', 0, 0x5f4850dc401411ecbe130cc47ad3b416, 0x299a128d2dbb11ec97710cc47ad3b416);
INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5145545678', 0, 0x5f48f9cf401411ecbe130cc47ad3b416, 0x299a13192dbb11ec97710cc47ad3b416);
INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5148645643', 0, 0x5f499666401411ecbe130cc47ad3b416, 0x299a13532dbb11ec97710cc47ad3b416);
INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5142345432', 0, 0x5f4a2b29401411ecbe130cc47ad3b416, 0x299a138f2dbb11ec97710cc47ad3b416);
INSERT INTO person VALUES (UNHEX(REPLACE(UUID(),'-','')), '5145543211', 1, 0x5f4ac008401411ecbe130cc47ad3b416, 0x9c37c15a35d011ec97710cc47ad3b416);














