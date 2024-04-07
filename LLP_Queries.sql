-- LANGUAGE LEARNING PLATFORM DATABASE

----------------------  DATABASE CREATION ------------------ 
IF EXISTS (SELECT name
FROM sys.databases
WHERE name = N'LanguageLearningPlatform')
        DROP DATABASE LanguageLearningPlatform
    GO

CREATE DATABASE [LanguageLearningPlatform]
    go
USE LanguageLearningPlatform
    go

================================================================
------------------------  TABLES -------------------------------

---CREATE TABLE PROFILE
CREATE TABLE profile
(
    profileId INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK(role in ('Admin', 'Instructor', 'User'))
);

------------------------------------------------------------------------

---CREATE TABLE USERPROFILE
CREATE TABLE userProfile
(
    userProfileId INT PRIMARY KEY IDENTITY(1,1),
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    dateOfBirth DATE NOT NULL,
    gender CHAR(1),
    isActive CHAR(3) NOT NULL,
    totalRewardPoints INT,
    role VARCHAR(50) DEFAULT 'User',
    subscriptionStatus VARCHAR(50) NOT NULL CHECK(subscriptionStatus in ('Premium', 'Regular'))
);

------------------------------------------------------------------------

---CREATE TABLE LANGUAGE COURSE
CREATE TABLE languageCourse
(
    languageCourseId INT PRIMARY KEY IDENTITY(1,1),
    languageName VARCHAR(50) NOT NULL,
    userProfileId INT NOT NULL,
    description VARCHAR(255)
        FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId)
);

------------------------------------------------------------------------

---CREATE TABLE RESOURCES
CREATE TABLE resources
(
    resourceId INT PRIMARY KEY IDENTITY(1,1),
    resourceType VARCHAR(50) NOT NULL,
    resourceContent VARCHAR(255),
    resourceLevel VARCHAR(50),
    languageCourseId INT NOT NULL,
    FOREIGN KEY (languageCourseId) REFERENCES languageCourse(languageCourseId)
);

------------------------------------------------------------------------

---CREATE TABLE ADMIN PROFILE
CREATE TABLE adminProfile
(
    adminProfileId INT PRIMARY KEY IDENTITY(1,1),
    contactNumber VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    resourceId INT NOT NULL,
    role VARCHAR(50) DEFAULT 'Admin',
    -- Setting 'admin' as the default value
    FOREIGN KEY (resourceId) REFERENCES resources(resourceId)
);

------------------------------------------------------------------------

---CREATE TABLE INSTRUCTOR PROFILE
CREATE TABLE instructorProfile
(
    instructorProfileId INT PRIMARY KEY IDENTITY(1,1),
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    languageCourseId INT NOT NULL,
    role VARCHAR(50) DEFAULT 'Instructor',
    FOREIGN KEY (languageCourseId) REFERENCES languageCourse(languageCourseId)
);

------------------------------------------------------------------------

---CREATE TABLE PREMIUM USER
CREATE TABLE premiumUser
(
    premiumProfileId INT PRIMARY KEY IDENTITY(1,1),
    monthlyCost DECIMAL(10, 2) NOT NULL DEFAULT '50.0',
    subscriptionStatus VARCHAR(50) DEFAULT 'Premium',
    userProfileId INT NOT NULL,
    FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId),
);

------------------------------------------------------------------------

---CREATE TABLE REGULAR USER
CREATE TABLE regularUser
(
    regularProfileId INT PRIMARY KEY IDENTITY(1,1),
    courseLimit INT DEFAULT 3,
    subscriptionStatus VARCHAR(50) DEFAULT 'Regular',
    userProfileId INT NOT NULL,
    FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId),
);

------------------------------------------------------------------------

---CREATE TABLE CONTEST 
CREATE TABLE contest
(
    contestId INT PRIMARY KEY IDENTITY(1,1),
    contestName VARCHAR(100) NOT NULL
);

------------------------------------------------------------------------

---CREATE TABLE CONTEST REWARD
CREATE TABLE contestReward
(
    contestrewardId INT PRIMARY KEY IDENTITY(1,1),
    rewardName VARCHAR(100) NOT NULL,
    points INT NOT NULL,
    ranking INT NOT NULL,
    userProfileId INT NOT NULL,
    contestId INT NOT NULL,
    FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId),
    FOREIGN KEY (contestId) REFERENCES contest(contestId)
);

------------------------------------------------------------------------

---CREATE TABLE USER RESOURCE ACCESS
CREATE TABLE userResourceAccess
(
    userAccessId INT PRIMARY KEY IDENTITY(1,1),
    userProfileId INT NOT NULL,
    resourceId INT NOT NULL,
    accessDate DATE NOT NULL,
    FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId),
    FOREIGN KEY (resourceId) REFERENCES resources(resourceId)
);

------------------------------------------------------------------------

---CREATE TABLE PREMIUM INSTRUCTOR ACCESS
CREATE TABLE premiumInstructorAccess
(
    premiumInstructorAccessId INT PRIMARY KEY IDENTITY(1,1),
    premiumProfileId INT NOT NULL,
    instructorProfileId INT NOT NULL,
    accessDate DATE NOT NULL,
    FOREIGN KEY (premiumProfileId) REFERENCES premiumUser(premiumProfileId),
    FOREIGN KEY (instructorProfileId) REFERENCES instructorProfile(instructorProfileId)
);

------------------------------------------------------------------------

---CREATE TABLE COURSE UNIT
CREATE TABLE courseUnit
(
    courseUnitId INT PRIMARY KEY IDENTITY(1,1),
    unitName VARCHAR(255) NOT NULL,
    unitDescription VARCHAR(1000),
    languageCourseId INT NOT NULL,
    FOREIGN KEY (languageCourseId) REFERENCES languageCourse(languageCourseId)
);

------------------------------------------------------------------------

---CREATE TABLE COURSE PROGRESS
CREATE TABLE courseProgress
(
    userCourseProgressId INT PRIMARY KEY IDENTITY(1,1),
    userProfileId INT NOT NULL,
    languageCourseId INT NOT NULL,
    progressPercent INT NOT NULL CHECK(progressPercent BETWEEN 0 AND 100),
    startDate DATE NOT NULL,
    completionDate DATE,
    FOREIGN KEY (userProfileId) REFERENCES userProfile(userProfileId),
    FOREIGN KEY (languageCourseId) REFERENCES languageCourse(languageCourseId)
);

------------------------------------------------------------------------

---CREATE TABLE LESSON
CREATE TABLE lesson
(
    lessonId INT PRIMARY KEY IDENTITY(1,1),
    lessonName VARCHAR(255) NOT NULL,
    courseUnitId INT NOT NULL,
    lessonContent VARCHAR(255),
    isLessonCompleted BIT,
    FOREIGN KEY (courseUnitId) REFERENCES courseUnit(courseUnitId)
);

------------------------------------------------------------------------

---CREATE TABLE QUIZ
CREATE TABLE quiz
(
    quizId INT PRIMARY KEY IDENTITY(1,1),
    description VARCHAR(255),
    lessonId INT,
    completionStatus BIT,
    FOREIGN KEY (lessonId) REFERENCES lesson(lessonId)
);

------------------------------------------------------------------------

---CREATE TABLE QUIZ CONTENT
CREATE TABLE quizContent
(
    quizContentId INT PRIMARY KEY IDENTITY(1,1),
    quizID INT NOT NULL,
    question VARCHAR(255) NOT NULL,
    FOREIGN KEY (quizID) REFERENCES quiz(quizID)
);

------------------------------------------------------------------------

---CREATE TABLE QUIZ OPTIONS
CREATE TABLE quizOptions
(
    quizOptionId INT PRIMARY KEY IDENTITY(1,1),
    quizContentId INT NOT NULL,
    optionText VARCHAR(255) NOT NULL,
    isCorrectAnswer BIT NOT NULL CHECK (isCorrectAnswer IN (0,1)),
    FOREIGN KEY (quizContentId) REFERENCES quizContent(quizContentId)
);

=================================================================
------------------------  STORED PROCEDURES ---------------------

    -- USE LanguageLearningPlatform
    GO
-- Enroll in Language Course - 1

CREATE PROCEDURE EnrollInLanguageCourse
    @userProfileId INT,
    @languageCourseId INT,
    @startDate DATE,
    @enrollmentStatus BIT OUTPUT
AS
BEGIN-- Check if the user is already enrolled in the course   
    IF NOT EXISTS (SELECT *
    FROM courseProgress
    WHERE userProfileId = @userProfileId AND languageCourseId = @languageCourseId)
        BEGIN
        INSERT INTO courseProgress
            (userProfileId, languageCourseId, progressPercent, startDate)
        VALUES
            (@userProfileId, @languageCourseId, 0, @startDate);
        SET @enrollmentStatus = 1;
    -- Successful enrollment
    END ELSE BEGIN
        SET @enrollmentStatus = 0;
    -- Enrollment failed, already enrolled
    END
END;
    GO

DECLARE @userProfileId INT = 69;
-- Specify the user profile ID
DECLARE @languageCourseId INT = 4;
-- Specify the language course ID
DECLARE @startDate DATE = '2024-03-16';
-- Specify the start date

DECLARE @enrollmentStatus BIT;
-- Output parameter

EXEC EnrollInLanguageCourse 
        @userProfileId = @userProfileId,
        @languageCourseId = @languageCourseId,
        @startDate = @startDate,
        @enrollmentStatus = @enrollmentStatus OUTPUT;

SELECT @enrollmentStatus AS 'Enrollment Status';

------------------------------------------------------------------------

    -- Award Contest Points - 2
    GO;

CREATE PROCEDURE AwardContestPoints
    @contestId INT,
    @userProfileId INT,
    @pointsAwarded INT,
    @ranking INT,
    @awardStatus BIT OUTPUT
AS
BEGIN-- Check if the awarding process is valid   
    IF EXISTS (SELECT *
        FROM contest
        WHERE contestId = @contestId) AND EXISTS (SELECT *
        FROM userProfile
        WHERE userProfileId = @userProfileId)
        BEGIN
        INSERT INTO contestReward
            (contestId, userProfileId, points, ranking)
        VALUES
            (@contestId, @userProfileId, @pointsAwarded, @ranking);
        -- Update user's total points 
        UPDATE userProfile
            SET totalRewardPoints = totalRewardPoints + @pointsAwarded WHERE userProfileId = @userProfileId;
        SET @awardStatus = 1;
    -- Successful awarding 
    END ELSE BEGIN
        SET @awardStatus = 0;
    -- Awarding failed due to invalid contestId or userProfileId 
    END
END;
    GO

-- Award Contest Points execution with below query

DECLARE @awardStatus BIT;

EXEC AwardContestPoints 
        @contestId = 1,
        @userProfileId = 21,
        @pointsAwarded = 100,
        @ranking = 1,
        @awardStatus = @awardStatus OUTPUT;

SELECT @awardStatus AS AwardStatus;

------------------------------------------------------------------------

    -- Manage User Resource Access - 3

    GO;

CREATE PROCEDURE ManageUserResourceAccess
    @userProfileId INT,
    @resourceId INT,
    @accessDate DATE,
    @accessStatus BIT OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT *
    FROM userResourceAccess
    WHERE userProfileId = @userProfileId AND resourceId = @resourceId)
        BEGIN
        INSERT INTO userResourceAccess
            (userProfileId, resourceId, accessDate)
        VALUES
            (@userProfileId, @resourceId, @accessDate);
        SET @accessStatus = 1;
    -- First time access recorded 
    END ELSE BEGIN
        UPDATE userResourceAccess
            SET accessDate = @accessDate WHERE userProfileId = @userProfileId AND resourceId = @resourceId;

        SET @accessStatus = 1;
    -- Access updated
    END
END;
    GO

DECLARE @userProfileId INT = 63;
-- Specify the user profile ID
DECLARE @resourceId INT = 1;
-- Specify the resource ID
DECLARE @accessDate DATE = '2024-04-10';
-- Specify the access date

DECLARE @accessStatus BIT;
-- Output parameter

EXEC ManageUserResourceAccess
        @userProfileId = @userProfileId,
        @resourceId = @resourceId,
        @accessDate = @accessDate,
        @accessStatus = @accessStatus OUTPUT;

SELECT @accessStatus AS 'Access Status';

------------------------------------------------------------------------

-- Update Course Progress - 4
GO;

CREATE PROCEDURE UpdateCourseProgress
    @userProfileId INT,
    @languageCourseId INT,
    @newProgressPercent INT,
    @updatedProgressPercent INT OUTPUT
AS
BEGIN
    UPDATE courseProgress
    SET progressPercent = @newProgressPercent,
        completionDate = CASE WHEN @newProgressPercent = 100 THEN GETDATE() 
        ELSE NULL
         END WHERE userProfileId = @userProfileId AND languageCourseId = @languageCourseId;
    SELECT @updatedProgressPercent = progressPercent
    FROM courseProgress
    WHERE userProfileId = @userProfileId AND languageCourseId = @languageCourseId;
END

GO

DECLARE @userProfileId INT = 64;
-- Specify the user profile ID
DECLARE @languageCourseId INT = 4;
-- Specify the language course ID
DECLARE @newProgressPercent INT = 100;
-- Specify the new progress percentage

DECLARE @updatedProgressPercent INT;
-- Output parameter

EXEC UpdateCourseProgress
    @userProfileId = @userProfileId,
    @languageCourseId = @languageCourseId,
    @newProgressPercent = @newProgressPercent,
    @updatedProgressPercent = @updatedProgressPercent OUTPUT;

SELECT @updatedProgressPercent AS 'Updated Progress Percent';

------------------------------------------------------------------------

--  Retrieve User Information - 5
GO;

CREATE PROCEDURE GetUserInformation
    @userProfileId INT,
    @firstName VARCHAR(50) OUTPUT,
    @lastName VARCHAR(50) OUTPUT,
    @dateOfBirth DATE OUTPUT,
    @gender CHAR(1) OUTPUT,
    @isActive CHAR(3) OUTPUT,
    @totalRewardPoints INT OUTPUT,
    @subscriptionStatus VARCHAR(50) OUTPUT
AS
BEGIN
    SELECT @firstName = firstName,
        @lastName = lastName,
        @dateOfBirth = dateOfBirth,
        @gender = gender,
        @isActive = isActive,
        @totalRewardPoints = totalRewardPoints,
        @subscriptionStatus = subscriptionStatus
    FROM userProfile
    WHERE userProfileId = @userProfileId;
END

-- Execute User Information from below query
DECLARE @firstName VARCHAR(50),
        @lastName VARCHAR(50),
        @dateOfBirth DATE,
        @gender CHAR(1),
        @isActive CHAR(3),
        @totalRewardPoints INT,
        @subscriptionStatus VARCHAR(50);

EXEC GetUserInformation 
    @userProfileId = 21,  -- Specify the userProfileId you want to retrieve information for
    @firstName = @firstName OUTPUT,
    @lastName = @lastName OUTPUT,
    @dateOfBirth = @dateOfBirth OUTPUT,
    @gender = @gender OUTPUT,
    @isActive = @isActive OUTPUT,
    @totalRewardPoints = @totalRewardPoints OUTPUT,
    @subscriptionStatus = @subscriptionStatus OUTPUT;

SELECT @firstName AS FirstName,
    @lastName AS LastName,
    @dateOfBirth AS DateOfBirth,
    @gender AS Gender,
    @isActive AS IsActive,
    @totalRewardPoints AS TotalRewardPoints,
    @subscriptionStatus AS SubscriptionStatus;

=================================================================

---------------------------  VIEWS ------------------------------

-- View for Instructor Course Details - 1

CREATE VIEW InstructorCourseDetails
AS
    SELECT ip.firstName, ip.lastName, ip.specialization, lc.languageName, lc.description
    FROM instructorProfile ip
        JOIN languageCourse lc ON ip.languageCourseId = lc.languageCourseId;

Select *
from InstructorCourseDetails

------------------------------------------------------------------------

-- View for User Profiles with Premium Subscription Status - 2

CREATE VIEW PremiumUserProfiles
AS
    SELECT up.userProfileId, up.firstName, up.lastName, up.dateOfBirth, up.gender,
        up.totalRewardPoints
    FROM userProfile up
    WHERE up.subscriptionStatus = 'Premium';

Select *
from PremiumUserProfiles

------------------------------------------------------------------------

-- View for Course Progress Overview - 3
CREATE VIEW CourseProgressOverview
AS
    SELECT up.firstName, up.lastName, lc.languageName, cp.progressPercent, cp.startDate, cp.completionDate
    FROM courseProgress cp JOIN userProfile up ON cp.userProfileId = up.userProfileId
        JOIN languageCourse lc ON cp.languageCourseId = lc.languageCourseId;

Select *
from CourseProgressOverview
where progressPercent >= 50

------------------------------------------------------------------------

-- View for Resource Access Logs - 4
CREATE VIEW UserResourceAccessLogs
AS
    SELECT up.firstName, up.lastName, r.resourceType, r.resourceContent, ura.accessDate
    FROM userResourceAccess ura JOIN userProfile up ON ura.userProfileId = up.userProfileId
        JOIN resources r ON ura.resourceId = r.resourceId;

Select *
from UserResourceAccessLogs
where resourceType = 'Book'

------------------------------------------------------------------------

-- View for Contest Participation and Rewards - 5
CREATE VIEW ContestParticipationRewards
AS
    SELECT up.firstName, up.lastName, c.contestName, cr.rewardName, cr.points, cr.ranking
    FROM contestReward cr
        JOIN userProfile up ON cr.userProfileId = up.userProfileId
        JOIN contest c ON cr.contestId = c.contestId;

Select *
from ContestParticipationRewards
where ranking >= 1

=================================================================
------------------------  FUNCTIONS -----------------------------

-- UDF for Calculating Age - 1
CREATE FUNCTION dbo.fn_CalculateAge(@dateOfBirth DATE)RETURNS INT AS BEGIN
    DECLARE @today DATE = GETDATE();
    DECLARE @age INT;

    SET @age = DATEDIFF(YEAR, @dateOfBirth, @today) - CASE WHEN
MONTH
(@dateOfBirth) > MONTH
(@today) OR
        (MONTH
(@dateOfBirth) = MONTH
(@today) AND DAY
(@dateOfBirth) > DAY
(@today)) THEN 1 ELSE 0 END;

    RETURN @age;
END;

ALTER TABLE userProfile ADD computedAge AS dbo.fn_CalculateAge(dateOfBirth);

Select *
from userProfile

------------------------------------------------------------------------

-- UDF for Calculating Course Duration - 2
CREATE FUNCTION dbo.fn_CalculateCourseDuration(@courseId INT)RETURNS INT AS BEGIN
    DECLARE @startDate DATE, @endDate DATE;

    SELECT @startDate = startDate, @endDate = completionDate
    FROM courseProgress
    WHERE languageCourseId = @courseId;

    RETURN DATEDIFF(DAY, @startDate, @endDate);
END;

ALTER TABLE courseProgress ADD courseDuration AS dbo.fn_CalculateCourseDuration(languageCourseId);

Select *
from courseProgress

=================================================================
----------------- COLUMN DATA ENCRYPTION ------------------------

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DMDDLLP@17';

SELECT name KeyName,
    symmetric_key_id KeyID,
    key_length KeyLength,
    algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

CREATE CERTIFICATE MyLanguageLearningPlatformCertificate WITH SUBJECT = 'Password Column Encryption Certificate';

CREATE SYMMETRIC KEY MySymmetricKey WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE MyLanguageLearningPlatformCertificate;


-- ALTER TABLE profile ADD passwordEncrypted VARBINARY(MAX);

OPEN SYMMETRIC KEY MySymmetricKey
DECRYPTION BY CERTIFICATE MyLanguageLearningPlatformCertificate;

UPDATE profile SET password = EncryptByKey(Key_GUID('MySymmetricKey'), password);

CLOSE SYMMETRIC KEY MySymmetricKey;

Select *
from profile

OPEN SYMMETRIC KEY MySymmetricKey
DECRYPTION BY CERTIFICATE MyLanguageLearningPlatformCertificate;

SELECT profileId, CONVERT(VARCHAR, DecryptByKey(password)) AS DecryptedPassword
FROM
    profile;

CLOSE SYMMETRIC KEY MySymmetricKey;

=================================================================
------------------------  INDEXES -------------------------------

-- Index on userProfile for subscriptionStatus - 1

CREATE NONCLUSTERED INDEX idx_userProfile_subscriptionStatus ON userProfile (subscriptionStatus);

SELECT *
FROM sys.indexes
WHERE name = 'idx_userProfile_subscriptionStatus';

-- Index on languageCourse for languageName - 2

CREATE NONCLUSTERED INDEX idx_languageCourse_languageName ON languageCourse (languageName);

SELECT *
FROM sys.indexes
WHERE name = 'idx_languageCourse_languageName';

-- Index on resources for resourceLevel and languageCourseId - 3

CREATE NONCLUSTERED INDEX idx_resources_level_courseId ON resources (resourceLevel, languageCourseId);

SELECT *
FROM sys.indexes
WHERE name = 'idx_resources_level_courseId';

-- Index on courseProgress for progressPercent and userProfileId - 4

CREATE NONCLUSTERED INDEX idx_courseProgress_progress_userProfile ON courseProgress (progressPercent, userProfileId);

SELECT *
FROM sys.indexes
WHERE name = 'idx_courseProgress_progress_userProfile';

-- Index on lesson for courseUnitId and isLessonCompleted - 5

CREATE NONCLUSTERED INDEX idx_lesson_unitId_completion ON lesson (courseUnitId, isLessonCompleted);

SELECT *
FROM sys.indexes
WHERE name = 'idx_lesson_unitId_completion';

=================================================================

------------------------  TRIGGERS ------------------------------
-- Trigger for Auditing New User Registrations - 1
    CREATE TABLE Audit_UserRegistrations
    (
        auditId INT not null PRIMARY KEY IDENTITY(1,1),
        userProfileId INT not null,
        registrationDate DATETIME,
        userName NVARCHAR(255)
    );
    GO;

-- Creates a trigger to audit new user registrations on the 'userProfile' table.
    GO;
    CREATE TRIGGER trg_AuditNewUserRegistration ON userProfile
        AFTER
        INSERT AS
        BEGIN
        INSERT INTO Audit_UserRegistrations
            (userProfileId, registrationDate, userName)
        SELECT i.userProfileId, GETDATE(), i.firstName + ' ' + i.lastName
        FROM inserted i;
    END;

    -- TO execute if the trigger inserted into the table Audit_UserRegistrations
    Select *
    from Audit_UserRegistrations

------------------------------------------------------------------------

    -- To update reward points on userProfile - 2
    -- Creates a trigger to update the total reward points on the 'userProfile' table after contest rewards are inserted.
    GO;

    CREATE TRIGGER AfterContestRewardInsert ON contestReward
    AFTER INSERT
    AS
    BEGIN
    UPDATE userProfile
        SET totalRewardPoints = totalRewardPoints + inserted.points
        FROM inserted
        WHERE userProfile.userProfileId = inserted.userProfileId;
    END;

------------------------------------------------------------------------

    -- Trigger to update Profile table with user, admin and instructor profile values - 3
    -- Creates a trigger to save user profiles to the 'profile' table after new users are inserted into the 'userProfile' table.
    
    GO;
    CREATE TRIGGER trg_SaveUserToProfile
    ON userProfile
    AFTER INSERT
    AS
    BEGIN
    INSERT INTO profile
        (username, email, password, role)
    SELECT CONCAT(firstName, '_', lastName), email, CONCAT(lastName, '@' , userProfileId), 'User'
    FROM inserted;
    END;

    -- To verify the userProfile trigger 
    Select *
    from profile

------------------------------------------------------------------------

    -- Trigger 4: Save Instructor Profile to Profile Table
    -- Creates a trigger to save instructor profiles to the 'profile' table after new instructors are inserted into the 'instructorProfile' table.
    GO;
    CREATE TRIGGER trg_SaveInstructorToProfile
    ON instructorProfile
    AFTER INSERT
    AS
    BEGIN
    INSERT INTO profile
        (username, email, password, role)
    SELECT CONCAT(firstName, '_', lastName), email, CONCAT(lastName, '@' , instructorProfileId), 'Instructor'
    FROM inserted;
    END;

    -- To verify the instructorProfile trigger
    Select *
    from profile

------------------------------------------------------------------------

    -- Trigger 5: Save Admin Profile to Profile Table
    -- Creates a trigger to save admin profiles to the 'profile' table after new admins are inserted into the 'adminProfile' table.
    GO;

    CREATE TRIGGER trg_SaveAdminToProfile
    ON adminProfile
    AFTER INSERT
    AS
    BEGIN
    INSERT INTO profile
        (username, email, password, role)
    SELECT 'admin_' + CAST(adminProfileId AS VARCHAR), email, CONCAT('admin', '@' , adminProfileId), 'Admin'
    FROM inserted;
    END;

    -- To verify the adminProfile trigger
    Select *
    from profile

------------------------------------------------------------------------

    -- Trigger 6: Insert User Subscription Data
    -- Creates a trigger to insert user subscription data into respective tables based on subscription status.

    GO;

    CREATE TRIGGER trg_InsertUserSubscription
    ON userProfile
    AFTER INSERT
    AS
    BEGIN
    INSERT INTO premiumUser
        (userProfileId)
    SELECT userProfileId
    FROM inserted
    WHERE subscriptionStatus = 'Premium';

    INSERT INTO regularUser
        (userProfileId)
    SELECT userProfileId
    FROM inserted
    WHERE subscriptionStatus = 'Regular';
    END;

    Select *
    from premiumUser
    Select *
    from regularUser
