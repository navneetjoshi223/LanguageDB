Language Learning Database Management System
## Overview

This project focuses on developing a language learning application using SQL for database management. The application aims to facilitate effective language acquisition by offering a variety of interactive learning modules.

## Background

A Language Learning System serves as an integrated solution for managing a diverse array of language learning materials, facilitating streamlined access to information, retrieving specific data, and preserving learning progress. Within the realm of language education, conventional methodologies often prove to be cumbersome and lack centralized coordination. Many language learners encounter challenges stemming from fragmented resources, impeding effective monitoring of their educational journey. The Language Learning System is designed to address these challenges by providing a centralized hub, enabling learners to seamlessly access, organize, and authenticate language-related data, resources, and achievements. Through the digitization of language learning records, the system ensures robust data integrity, thereby mitigating the risk of data loss or tampering.

## Features

	1.	User Management:
	•	Secure user authentication
	•	Profile management
	•	Personalized learning experience
	2.	Course and Lesson Management:
	•	Comprehensive database for storing course and lesson information
	•	Supports multimedia content (text, audio, video)
	3.	Progress Tracking:
	•	Tracks user progress through courses and lessons
	•	Records completed modules and scores
	•	Provides feedback on performance
	4.	Quiz and Assessment:
	•	Integrated quizzes and assessments
	•	Stores questions, user responses, and results
	5.	Leaderboard and Gamification:
	•	Competitive learning environment
	•	Users earn points and badges based on performance
	6.	Multilingual Support:
	•	Supports multiple languages
	•	Easy accommodation for future language additions
	7.	Scalability and Performance:
	•	Optimized database structure
	•	Efficient data retrieval and storage

## Database Schema

The project consists of a well-structured SQL database with the following components:

	1.	Tables:
	•	Profile: Stores user profiles with attributes such as username, email, password, and role.
	•	Admin: Stores admin-specific details, including contact number and associated resources.
	•	Instructor: Contains instructor-specific information such as first name, last name, and specialization.
	•	User: Maintains user details including first name, last name, date of birth, gender, activity status, total reward points, and subscription status.
	•	Contest: Holds information about various contests.
	•	ContestReward: Tracks rewards given to users for participating in contests.
	•	LanguageCourse: Stores information about the language courses offered, including the course name and description.
	•	CourseUnit: Contains details about individual units within a language course.
	•	Lesson: Stores lessons associated with each course unit, including lesson name, content, and completion status.
	•	CourseProgress: Tracks user progress in different language courses, including progress percentage, start date, and completion date.
	•	UserResourceAccess: Records access details of users to various resources.
	•	Resources: Contains resource information such as resource type, content, and language level.
	•	PremiumInstructorAccess: Tracks access details for premium instructors.
	•	RegularUser: Contains details specific to regular users, including course limits.
	•	PremiumUser: Contains details specific to premium users, including monthly costs.
	•	Quiz: Stores information about quizzes associated with lessons, including quiz description and completion status.
	•	QuizContent: Contains questions for each quiz.
	•	QuizOptions: Holds the options for each quiz question, including whether the option is correct or not.
	2.	Views:
	•	UserProgressView: Aggregates user progress data for quick access to overall progress.
	•	CourseSummaryView: Provides a summary of each course, including the number of lessons and enrolled users.
	3.	Stored Procedures:
	•	AddUser: Procedure to add a new user to the database.
	•	UpdateProgress: Procedure to update the progress of a user in a specific course or lesson.
	•	RecordQuizResponse: Procedure to record the user’s response to a quiz question and calculate the score.
	4.	Triggers:
	•	UpdateLeaderboard: Trigger to update the leaderboard whenever a user’s progress or quiz result changes.
	5.	Indexes:
	•	UserIndex: Index on the Users table to speed up user lookup.
	•	CourseIndex: Index on the Courses table to optimize course retrieval.
