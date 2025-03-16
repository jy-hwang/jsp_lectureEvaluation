DROP TABLE IF EXISTS users;

CREATE TABLE `users` (
  `user_no` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(20) NOT NULL,
  `user_password` varchar(64) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_email_hash` varchar(64) NOT NULL,
  `user_email_checked` tinyint(1) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS evaluations;

CREATE TABLE `evaluations` (
`evaluation_no` bigint(20) NOT NULL AUTO_INCREMENT,
`user_no` bigint(20) NOT NULL,
`lecture_name` varchar(50) NOT NULL,  
`professor_name` varchar(20) NOT NULL,
`lecture_year` mediumint NOT NULL,
`semester_divide` varchar(20) NOT NULL,
`lecture_divide` varchar(10) NOT NULL,
`evaluation_title` varchar(50) NOT NULL,  
`evaluation_content` varchar(2048) NOT NULL,  
`total_score` varchar(5) NOT NULL,
`credit_score` varchar(5) NOT NULL,
`comfortable_score` varchar(5) NOT NULL,
`lecture_score` varchar(5) NOT NULL,
`like_count` mediumint NOT NULL,
`created_date` timestamp NOT NULL DEFAULT current_timestamp(),
`updated_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`evaluation_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS likeys;

CREATE TABLE `likeys` (
`evaluation_no` bigint(20) NOT NULL,
`user_no` bigint(20) NOT NULL,
`user_ip` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
