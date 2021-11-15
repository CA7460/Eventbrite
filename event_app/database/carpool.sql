CREATE TABLE `carpool` (
  `carpoolid` BINARY(16) PRIMARY KEY,
  `createdOn` DATETIME NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `numberOfSeats` INT(2) NOT NULL,
  `status` BIT(1),
  `driverid` BINARY(16) NOT NULL,
  `passengerid` BINARY(16) NOT NULL,
  `eventid` BINARY(16) NOT NULL,
  `pickupaddressid` BINARY(16) NOT NULL,
  CONSTRAINT `carpool_person_driverid` FOREIGN KEY (`driverid`) REFERENCES `person` (`personid`),
  /*CONSTRAINT `carpool_carpool_person_passengerid` FOREIGN KEY (`passengerid`) REFERENCES `carpool_person` (`carpoolpersonid`),*/
  CONSTRAINT `carpool_event_eventid` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`),
  CONSTRAINT `carpool_address_addressid` FOREIGN KEY (`pickupaddressid`) REFERENCES `address` (`addressid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `carpool_person` (
	`carpoolpersonid` BINARY(16) PRIMARY KEY,
	`carpoolid` BINARY(16) NOT NULL,
	`personid` BINARY(16) NOT NULL,
	CONSTRAINT `carpool_person_carpool_carpoolid` FOREIGN KEY (`carpoolid`) REFERENCES `carpool` (`carpoolid`),
	CONSTRAINT `carpool_person_person_personid` FOREIGN KEY (`personid`) REFERENCES `person` (`personid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*ALTER TABLE `carpool` ADD CONSTRAINT `carpool_carpool_person_passengerid` FOREIGN KEY (`passengerid`) REFERENCES `carpool_person` (`carpoolpersonid`);*/

INSERT INTO `carpool_person` VALUES (UNHEX(REPLACE(UUID(),'-','')), 0x0cf845a0403a11ecbe130cc47ad3b416, 0xc5b7559c401b11ecbe130cc47ad3b416);
INSERT INTO `carpool_person` VALUES (UNHEX(REPLACE(UUID(),'-','')), 0x0dc3274d403911ecbe130cc47ad3b416, 0xc5b61d28401b11ecbe130cc47ad3b416);


INSERT INTO `carpool` VALUES (UNHEX(REPLACE(UUID(),'-','')), DATE_ADD(NOW(), INTERVAL -30 HOUR), 'See concert 1', 'Concert 1 Description', 10.0, 4, 1, 0xc5b56063401b11ecbe130cc47ad3b416, 0xc5b61d28401b11ecbe130cc47ad3b416, 0x0d70522f2dbb11ec97710cc47ad3b416, 0x5f47afad401411ecbe130cc47ad3b416);

INSERT INTO `carpool` VALUES (UNHEX(REPLACE(UUID(),'-','')), DATE_ADD(NOW(), INTERVAL -630 HOUR), 'See concert 1', 'Concert 1 Description', 10.0, 4, 1, 0xc5b56063401b11ecbe130cc47ad3b416, 0xc5b7559c401b11ecbe130cc47ad3b416, 0x0d70522f2dbb11ec97710cc47ad3b416, 0x5f47afad401411ecbe130cc47ad3b416);