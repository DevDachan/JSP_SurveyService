CREATE DATABASE `survey_service` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use survey_service;


CREATE TABLE `emailcode` (
  `email` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `option_detail` (
  `survey_id` int NOT NULL,
  `option_num` int NOT NULL,
  `option_title` varchar(50) DEFAULT NULL,
  `option_content` varchar(2048) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`option_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `admin_id` varchar(50) NOT NULL,
  `content` varchar(2048) DEFAULT NULL,
  `result_option` int DEFAULT NULL,
  `limit_state` int DEFAULT NULL,
  `edit_state` int DEFAULT NULL,
  PRIMARY KEY (`id`,`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey_history` (
  `survey_id` int NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `history_index` int NOT NULL,
  `option_num` int NOT NULL,
  `component_num` int NOT NULL,
  `content` varchar(2048) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
   PRIMARY KEY (`survey_id`,`user_id`,`history_index`,`option_num`,`component_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey_option` (
  `survey_id` int NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `option_num` int NOT NULL,
  `component_num` int NOT NULL,
  `content` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`option_num`,`component_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `survey_result` (
  `survey_id` int NOT NULL,
  `option_num` int NOT NULL,
  `component_num` int NOT NULL,
  `content` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`option_num`,`component_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `id` varchar(50) NOT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `user_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;










