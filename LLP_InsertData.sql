-------------------------------DATA INSERTION--------------------------------
-- userProfile table data

INSERT INTO userProfile (firstName, lastName, email, dateOfBirth, gender, isActive, totalRewardPoints, subscriptionStatus)
VALUES 
('Bindu', 'Pagad', 'bindu.pagad@llp.com', '1990-05-15', 'F', 'Yes', 500, 'Premium'),
('Anu', 'Senthil', 'anu.senthil@llp.com', '1985-08-25', 'F', 'Yes', 750, 'Regular'),
('Thivya', 'Dhanasegaren', 'thivya.dhanasegaren@llp.com', '1982-12-10', 'F', 'Yes', 1000, 'Premium'),
('Ashwin', 'Ramkumar', 'ashwin.ramkumar@llp.com', '1995-03-20', 'M', 'Yes', 250, 'Regular'),
('Navneet', 'Joshi', 'navneet.joshi@llp.com', '1978-07-05', 'M', 'No', 0, 'Regular'),
('Sarah', 'Anderson', 'sarah.anderson@llp.com', '1989-11-30', 'F', 'Yes', 1250, 'Premium'),
('David', 'Martinez', 'david.martinez@llp.com', '1980-09-18', 'M', 'Yes', 800, 'Premium'),
('Jessica', 'Taylor', 'jessica.taylor@llp.com', '1992-02-12', 'F', 'Yes', 300, 'Regular'),
('Christopher', 'Thomas', 'christopher.thomas@llp.com', '1987-06-28', 'M', 'No', 0, 'Regular'),
('Amanda', 'Garcia', 'amanda.garcia@llp.com', '1984-04-08', 'F', 'Yes', 600, 'Premium');

select * from userProfile;
-------------------------------------------------------------------------------

-- languageCourse table data
INSERT INTO languageCourse (languageName, description, userProfileId)
VALUES('English', 'Learn English language skills', 1), 
('Spanish', 'Learn Spanish language skills',2), 
('French', 'Learn French language skills',3), 
('German', 'Learn German language skills',4), 
('Italian', 'Learn Italian language skills',5), 
('Mandarin', 'Learn Mandarin language skills',6), 
('Japanese', 'Learn Japanese language skills',7), 
('Russian', 'Learn Russian language skills',8), 
('Arabic', 'Learn Arabic language skills',9), 
('Portuguese', 'Learn Portuguese language skills',10);

SELECT * from languageCourse;
---------------------------------------------------------------------------------

-- resources table data
INSERT INTO resources (resourceType, resourceContent, resourceLevel, languageCourseId)
VALUES
('Book', 'English Grammar Book', 'Beginner', 1), 
('Video', 'Spanish Conversation Tutorial', 'Intermediate', 2), 
('Audio', 'French Pronunciation Audio', 'Advanced', 3),
('Book', 'German Vocabulary Book', 'Beginner', 4), 
('Video', 'Italian Language Course', 'Intermediate', 5), 
('Audio', 'Mandarin Pronunciation Audio', 'Advanced', 6),
('Book', 'Japanese Grammar Book', 'Beginner', 7), 
('Video', 'Russian Language Course', 'Intermediate', 8), 
('Audio', 'Arabic Pronunciation Audio', 'Advanced', 9),
('Book', 'Portuguese Vocabulary Book', 'Beginner', 10);

SELECT * from resources;
---------------------------------------------------------------------------------

-- adminProfile table data
INSERT INTO adminProfile (contactNumber, email, resourceId)
VALUES ('1234567890', 'admin1@llp.com', 2);

SELECT * from adminProfile
---------------------------------------------------------------------------------

-- instructorProfile table data
INSERT INTO instructorProfile (firstName, lastName, email, specialization, languageCourseId)
VALUES 
('John', 'Smith', 'john.smith@llp.com', 'English Grammar', 1),
('Alice', 'Johnson', 'alice.johnson@llp.com', 'Spanish Conversation', 2),
('Michael', 'Williams', 'michael.williams@llp.com', 'French Literature', 3),
('Emily', 'Brown', 'emily.brown@llp.com', 'German Language', 4),
('James', 'Jones', 'james.jones@llp.com', 'Chinese Mandarin', 5),
('Sarah', 'Davis', 'sarah.davis@llp.com', 'Japanese Culture', 6),
('David', 'Taylor', 'david.taylor@llp.com', 'Russian History', 7),
('Jessica', 'Miller', 'jessica.miller@llp.com', 'Italian Cuisine', 8),
('Christopher', 'Wilson', 'christopher.wilson@llp.com', 'Arabic Literature', 9),
('Amanda', 'Martinez', 'amanda.martinez@llp.com', 'Korean Language', 10);

select * from instructorProfile;

---------------------------------------------------------------------------------
-- contest table data
INSERT INTO contest (contestName)
VALUES
('Spanish Challenge'),
('Greek Olympiad'),
('English Quiz'),
('Tamil Competition'),
('French Bee'),
('Japanese Tournament'),
('German Competition'),
('Urdu Contest'),
('Dutch Challenge'),
('Burmese Contest');

select * from contest;

---------------------------------------------------------------------------------

-- contestReward table data
INSERT INTO contestReward (rewardName, points, ranking, userProfileId, contestId)
VALUES
('Gold Medal', 100, 1, 1, 1),
('Silver Medal', 75, 2, 2, 1),
('Bronze Medal', 50, 3, 3, 1),
('Certificate of Participation', 25, 4, 4, 1),
('Consolation Prize', 10, 5, 5, 1),
('First Prize', 100, 1, 6, 2),
('Second Prize', 75, 2, 7, 2),
('Third Prize', 50, 3, 8, 2),
('Honorable Mention', 25, 4, 9, 2),
('Participation Award', 10, 5, 10, 2);

SELECT * from contestReward;

---------------------------------------------------------------------------------

-- userResourceAccess table data
INSERT INTO userResourceAccess (userProfileId, resourceId, accessDate)
VALUES
(1, 1, '2024-03-25'),
(2, 2, '2024-03-26'),
(3, 3, '2024-03-27'),
(4, 4, '2024-03-28'),
(5, 5, '2024-03-29'),
(6, 6, '2024-03-30'),
(7, 7, '2024-03-31'),
(8, 8, '2024-04-01'),
(9, 9, '2024-04-02'),
(10, 10, '2024-04-03');

SELECT * from userResourceAccess;

---------------------------------------------------------------------------------

-- premiumInstructorAccess table data
INSERT INTO premiumInstructorAccess (premiumProfileId, instructorProfileId, accessDate)
VALUES
(3, 11, '2024-03-25'),
(3, 2, '2024-03-26'),
(4, 3, '2024-03-27'),
(4, 4, '2024-03-28'),
(5, 5, '2024-03-29'),
(1, 6, '2024-03-30'),
(2, 7, '2024-03-31'),
(3, 8, '2024-04-01'),
(4, 9, '2024-04-02'),
(5, 10, '2024-04-03');

SELECT * from premiumInstructorAccess
---------------------------------------------------------------------------------
-- courseProgress table data
INSERT INTO courseProgress (userProfileId, languageCourseId, progressPercent, startDate, completionDate)
VALUES
(1, 2, 67, '2024-03-01', NULL),
(2, 4, 88, '2024-03-05', NULL),
(3, 4, 31, '2024-03-10', NULL),
(4, 4, 100, '2024-03-15', '2024-03-20'),
(5, 2, 76, '2024-03-01', NULL),
(6, 2, 54, '2024-03-05', NULL),
(7, 3, 80, '2024-03-10', NULL),
(8, 3, 60, '2024-03-15', NULL),
(9, 3, 80, '2024-03-20', NULL),
(10, 3, 20, '2024-03-01', NULL);

SELECT * FROM courseProgress

---------------------------------------------------------------------------------

-- courseUnit table data
INSERT INTO courseUnit (unitName, unitDescription, languageCourseId)
VALUES
('Basic Vocabulary', 'This unit covers essential vocabulary for beginners.', 3),
('Grammar Essentials', 'This unit focuses on fundamental grammar rules and structures.', 3),
('Conversation Practice', 'This unit provides practice exercises for improving conversational skills.', 3),
('Reading Comprehension', 'This unit helps learners improve their reading skills by understanding texts.', 3),
('Writing Skills Development', 'This unit focuses on improving writing proficiency through exercises and feedback.', 3),
('Advanced Vocabulary', 'This unit covers more complex vocabulary for intermediate learners.', 3),
('Idioms and Expressions', 'This unit explores common idiomatic expressions used in everyday language.', 3),
('Cultural Insights', 'This unit introduces learners to cultural aspects associated with the language.', 3),
('Listening Practice', 'This unit provides exercises to enhance listening comprehension skills.', 3),
('Speaking Fluency', 'This unit aims to improve speaking fluency through interactive activities and discussions.', 3),

('Basic Vocabulary', 'This unit covers essential vocabulary for beginners.', 2),
('Grammar Essentials', 'This unit focuses on fundamental grammar rules and structures.', 2),
('Conversation Practice', 'This unit provides practice exercises for improving conversational skills.', 2),
('Reading Comprehension', 'This unit helps learners improve their reading skills by understanding texts.', 2),
('Writing Skills Development', 'This unit focuses on improving writing proficiency through exercises and feedback.', 2),
('Advanced Vocabulary', 'This unit covers more complex vocabulary for intermediate learners.', 2),
('Idioms and Expressions', 'This unit explores common idiomatic expressions used in everyday language.', 2),
('Cultural Insights', 'This unit introduces learners to cultural aspects associated with the language.', 2),
('Listening Practice', 'This unit provides exercises to enhance listening comprehension skills.', 2),
('Speaking Fluency', 'This unit aims to improve speaking fluency through interactive activities and discussions.', 2);

SELECT * from courseUnit

---------------------------------------------------------------------------------

-- lesson table data
INSERT INTO lesson (lessonName, courseUnitId, lessonContent, isLessonCompleted)
VALUES
('Greetings and Introductions', 1, 'Learn common greetings and how to introduce yourself.', 0),
('Basic Verb Conjugation', 2, 'Understand how to conjugate verbs in present tense.', 0),
('Family and Relationships Vocabulary', 1, 'Expand your vocabulary related to family and relationships.', 0),
('Simple Present Tense', 2, 'Learn to use simple present tense to describe habits and routines.', 0),
('Numbers and Counting', 1, 'Practice counting and learn cardinal and ordinal numbers.', 0),
('Food and Drinks Vocabulary', 1, 'Learn vocabulary related to food and drinks.', 0),
('Present Continuous Tense', 2, 'Understand the present continuous tense and its usage.', 0),
('Daily Routine Vocabulary', 1, 'Expand your vocabulary to describe daily routines and activities.', 0),
('Places and Directions Vocabulary', 1, 'Learn vocabulary related to places and giving directions.', 0),
('Past Simple Tense', 2, 'Understand how to use the past simple tense to talk about past events.', 0);

SELECT * from lesson;

---------------------------------------------------------------------------------
-- quiz table data
INSERT INTO quiz (description, lessonId, completionStatus)
VALUES
('Quiz 1: Greetings and Introductions', 3, 1),
('Quiz 2: Basic Verb Conjugation', 2, 0),
('Quiz 3: Family and Relationships Vocabulary', 3, 1),
('Quiz 4: Simple Present Tense', 4, 0),
('Quiz 5: Numbers and Counting', 5, 1),
('Quiz 6: Food and Drinks Vocabulary', 6, 0),
('Quiz 7: Present Continuous Tense', 7, 1),
('Quiz 8: Daily Routine Vocabulary', 8, 0),
('Quiz 9: Places and Directions Vocabulary', 9, 1),
('Quiz 10: Past Simple Tense', 10, 0);

SELECT * from quiz

---------------------------------------------------------------------------------
-- quizContent table data
INSERT INTO quizContent (quizID, question)
VALUES 
    (1, 'What is the capital of France?'),
    (1, 'Who wrote the famous play "Romeo and Juliet"?'),
    (2, 'What is the chemical symbol for water?'),
    (2, 'Who invented the telephone?'),
    (3, 'Which planet is known as the Red Planet?'),
    (3, 'Who painted the Mona Lisa?'),
    (4, 'What is the largest mammal in the world?'),
    (4, 'Who discovered penicillin?'),
    (5, 'What is the tallest mountain on Earth?'),
    (5, 'Who was the first female Prime Minister of the United Kingdom?');

    SELECT * from quizContent

---------------------------------------------------------------------------------
-- quizOptions table data
INSERT INTO quizOptions (quizContentId, optionText, isCorrectAnswer)
VALUES
    (2, 'London', 0),
    (2, 'Paris', 1),
    (2, 'Berlin', 0),
    (2, 'William Shakespeare', 1),
    (2, 'Charles Dickens', 0),
    (2, 'Jane Austen', 0),
    (3, 'H2O', 1),
    (3, 'CO2', 0),
    (3, 'O2', 0),
    (4, 'Alexander Graham Bell', 1),
    (4, 'Thomas Edison', 0),
    (4, 'Albert Einstein', 0),
    (5, 'Mars', 1),
    (5, 'Venus', 0),
    (5, 'Mercury', 0),
    (6, 'Leonardo da Vinci', 1),
    (6, 'Pablo Picasso', 0),
    (6, 'Vincent van Gogh', 0),
    (7, 'Blue whale', 1),
    (7, 'Elephant', 0),
    (7, 'Giraffe', 0),
    (8, 'Marie Curie', 0),
    (8, 'Alexander Fleming', 1),
    (8, 'Isaac Newton', 0),
    (9, 'Mount Kilimanjaro', 0),
    (9, 'Mount Everest', 1),
    (9, 'Mount Fuji', 0),
    (10, 'Margaret Thatcher', 1),
    (10, 'Angela Merkel', 0),
    (10, 'Jacinda Ardern', 0);

    select * from quizOptions

---------------------------------------------------------------------------------
