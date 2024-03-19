## ERD cloud에서 export한 것에서 cascade, auto_increment 추가 해서 최종 생성

```
CREATE TABLE `input` (
                         `input_id` int NOT NULL AUTO_INCREMENT,
                         `input_name` varchar(50) NOT NULL,
                         `input_quantity` long NOT NULL,
                         `input_day` DATE NOT NULL,
                         `input_grade` char NOT NULL,
                         `iaccount_number` int NOT NULL,
                         PRIMARY KEY (`input_id`)
);

CREATE TABLE `business` (
                            `business_id` int NOT NULL AUTO_INCREMENT,
                            `business_name` varchar(30) NOT NULL,
                            `business_password` varchar(50) NOT NULL,
                            `business_number` varchar(20) NOT NULL,
                            `business_link` varchar(150) NULL,
                            PRIMARY KEY (`business_id`)
);

CREATE TABLE `input_account` (
                                 `iaccount_number` int NOT NULL AUTO_INCREMENT,
                                 `iaccount_name` varchar(100) NOT NULL,
                                 `iaccount_address` varchar(150) NOT NULL,
                                 `business_id` int NOT NULL,
                                 PRIMARY KEY (`iaccount_number`),
                                 FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE CASCADE
);

CREATE TABLE `storage` (
                           `storage_number` int NOT NULL AUTO_INCREMENT,
                           `business_id` int NOT NULL,
                           `storage_address` varchar(100) NOT NULL,
                           `storage_volume` long NOT NULL,
                           PRIMARY KEY (`storage_number`),
                           FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE CASCADE
);

CREATE TABLE `adjustment` (
                              `adjustment_number` int NOT NULL AUTO_INCREMENT,
                              `adjustment_date` DATE NOT NULL,
                              `adjustment_price` long NOT NULL,
                              `adjustment_state` varchar(10) NOT NULL DEFAULT '미정산',
                              `business_id` int NOT NULL,
                              `oaccount_number` int NOT NULL,
                              PRIMARY KEY (`adjustment_number`),
                              FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE CASCADE
);

CREATE TABLE `inventory` (
                             `input_id` int NOT NULL,
                             `storage_number` int NOT NULL,
                             `inventory_name` varchar(30) NOT NULL,
                             `inventory_grade` char NOT NULL,
                             `inventory_quantity` long NOT NULL,
                             `goodstag_num` int NOT NULL,
                             PRIMARY KEY (`input_id`, `storage_number`),
                             FOREIGN KEY (`input_id`) REFERENCES `input` (`input_id`) ON DELETE CASCADE,
                             FOREIGN KEY (`storage_number`) REFERENCES `storage` (`storage_number`) ON DELETE CASCADE
);

CREATE TABLE `output_account` (
                                  `oaccount_number` int NOT NULL AUTO_INCREMENT,
                                  `oaccount_name` varchar(30) NOT NULL,
                                  `oaccount_address` varchar(300) NOT NULL,
                                  `business_id` int NOT NULL,
                                  PRIMARY KEY (`oaccount_number`),
                                  FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE CASCADE
);

CREATE TABLE `delivery` (
                            `deliver_number` varchar(10) NOT NULL,
                            `deliver_address` varchar(30) NOT NULL,
                            `deliver_arrive` DATE NULL,
                            `deliver_date` DATE NULL,
                            `order_number` int NOT NULL,
                            PRIMARY KEY (`deliver_number`),
                            FOREIGN KEY (`order_number`) REFERENCES `order` (`order_number`) ON DELETE CASCADE
);

CREATE TABLE `goodstag` (
                            `goodstag_num` int NOT NULL AUTO_INCREMENT,
                            `goodstag_context` varchar(30) NOT NULL,
                            `business_id` int NOT NULL,
                            PRIMARY KEY (`goodstag_num`),
                            FOREIGN KEY (`business_id`) REFERENCES `business` (`business_id`) ON DELETE CASCADE
);

CREATE TABLE `order` (
                         `order_number` int NOT NULL AUTO_INCREMENT,
                         `order_date` DATE NOT NULL DEFAULT SYSDATE,
                         `oaccount_number` int NOT NULL,
                         PRIMARY KEY (`order_number`),
                         FOREIGN KEY (`oaccount_number`) REFERENCES `output_account` (`oaccount_number`) ON DELETE CASCADE
);

CREATE TABLE `order_product` (
                                 `order_number` int NOT NULL,
                                 `input_id` int NOT NULL,
                                 `quantity` long NOT NULL,
                                 PRIMARY KEY (`order_number`, `input_id`),
                                 FOREIGN KEY (`order_number`) REFERENCES `order` (`order_number`) ON DELETE CASCADE,
                                 FOREIGN KEY (`input_id`) REFERENCES `inventory` (`input_id`) ON DELETE CASCADE
);
```
