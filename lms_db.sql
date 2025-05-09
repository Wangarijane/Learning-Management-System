-- DROP existing database
DROP DATABASE IF EXISTS lms_db;
CREATE DATABASE lms_db;
USE lms_db;

-- Users table: Stores both students and instructors
CREATE TABLE users (
user_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
role ENUM('student', 'instructor', 'admin') NOT NULL,
password VARCHAR(255) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Courses table
CREATE TABLE courses (
course_id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(150) NOT NULL,
description TEXT,
instructor_id INT NOT NULL,
FOREIGN KEY (instructor_id) REFERENCES users(user_id)
);

-- Enrollments table (M:M between students and courses)
CREATE TABLE enrollments (
enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
course_id INT NOT NULL,
enrolled_on DATE NOT NULL,
UNIQUE(student_id, course_id),
FOREIGN KEY (student_id) REFERENCES users(user_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Lessons table (1:M with courses)
CREATE TABLE lessons (
lesson_id INT AUTO_INCREMENT PRIMARY KEY,
course_id INT NOT NULL,
title VARCHAR(150) NOT NULL,
content TEXT,
video_url VARCHAR(255),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Assignments table
CREATE TABLE assignments (
assignment_id INT AUTO_INCREMENT PRIMARY KEY,
course_id INT NOT NULL,
title VARCHAR(150) NOT NULL,
description TEXT,
due_date DATE,
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Submissions table (1:M with assignments & users)
CREATE TABLE submissions (
submission_id INT AUTO_INCREMENT PRIMARY KEY,
assignment_id INT NOT NULL,
student_id INT NOT NULL,
submission_text TEXT,
submitted_on DATETIME,
grade DECIMAL(5,2),
FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
FOREIGN KEY (student_id) REFERENCES users(user_id)
);