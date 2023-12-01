/*
Cole Thorpen
November 5, 2023
IMT 543
Project Deliverable 4
*/

/*
REQUIREMENTS OF PROJECT DELIVERABLE #4 BEGIN ON LINE 267
*/

-- Create the database
DROP DATABASE AthleticClub;
CREATE DATABASE AthleticClub;

-- use this database
USE AthleticClub;
GO

/*
CREATE TABLE statements for all entities
*/
-- MEMBER 
CREATE TABLE tblMEMBER (
    MemberID INT IDENTITY PRIMARY KEY NOT NULL,
    MemberFname VARCHAR(50) NOT NULL,
    MemberLname VARCHAR(50) NOT NULL,
    MemberAddress VARCHAR(50) NOT NULL,
    MemberCity VARCHAR(50) NOT NULL,
    MemberState VARCHAR(20) NOT NULL,
    MemberZip VARCHAR(5) NOT NULL,
    GymID INT NOT NULL, -- FK 
    Email VARCHAR(50) NOT NULL
);

-- CLASS
CREATE TABLE tblCLASS (
    ClassID INT IDENTITY PRIMARY KEY NOT NULL,
    ClassName VARCHAR(50) NOT NULL,
    ClassTypeID INT NOT NULL, -- FK 
    ClassTime VARCHAR(10),
    ClassDate DATE,
    GymID INT NOT NULL -- FK 
);

-- CLASS_LIST
CREATE TABLE tblCLASS_LIST (
    ClassID INT NOT NULL, -- FK 
    MemberID INT NOT NULL, -- FK
    RegistrationFee NUMERIC
);

-- CLASS_TYPE
CREATE TABLE tblCLASS_TYPE (
    ClassTypeID INT IDENTITY PRIMARY KEY NOT NULL,
    ClassTypeName VARCHAR(50) NOT NULL,
    DurationInHours NUMERIC
);

-- GYM
CREATE TABLE tblGYM (
    GymID INT IDENTITY PRIMARY KEY NOT NULL,
    GymName VARCHAR(50) NOT NULL,
    GymAddress VARCHAR(50) NOT NULL,
    GymCity VARCHAR(50) NOT NULL,
    GymState VARCHAR(50) NOT NULL,
    GymZip VARCHAR(5) NOT NULL
);

-- STAFF
CREATE TABLE tblSTAFF (
    StaffID INT IDENTITY PRIMARY KEY NOT NULL,
    StaffFname VARCHAR(50) NOT NULL,
    StaffLname VARCHAR(50) NOT NULL,
    StaffTypeID INT NOT NULL, -- FK 
    GymID INT NOT NULL, -- FK 
    StaffAddress VARCHAR(50),
    StaffCity VARCHAR(50),
    StaffState VARCHAR(50),
    StaffZip VARCHAR(5),
    HoursPerWeek FLOAT,
    PayRate FLOAT
);

-- STAFF_TYPE
CREATE TABLE tblSTAFF_TYPE (
    StaffTypeID INT IDENTITY PRIMARY KEY NOT NULL,
    StaffTypeName VARCHAR(50),
    StaffTypeDescription VARCHAR(50)
);

-- EXERCISE
CREATE TABLE tblEXERCISE (
    ExerciseID INT IDENTITY PRIMARY KEY NOT NULL,
    ExerciseName VARCHAR(50) UNIQUE NOT NULL,
    MusclesWorked VARCHAR(50),
    EquipmentID INT NOT NULL, --FK 
    ExerciseTypeID INT NOT NULL --FK 
);

-- EXERCISE_LIST
CREATE TABLE tblEXERCISE_LIST (
    ClassID INT NOT NULL, -- FK
    ExerciseID INT NOT NULL, -- FK
    ExerciseName VARCHAR(50) -- FK 
);

-- EXERCISE_TYPE
CREATE TABLE tblEXERCISE_TYPE (
    ExerciseTypeID INT IDENTITY PRIMARY KEY NOT NULL,
    ExerciseTypeName VARCHAR(50) NOT NULL,
    ExerciseDesc VARCHAR(50)
);

-- EQUIPMENT
CREATE TABLE tblEQUIPMENT (
    EquipmentID INT IDENTITY PRIMARY KEY NOT NULL, 
    EquipmentName VARCHAR(50) NOT NULL,
    EquipmentTypeID INT NOT NULL -- FK 
);

-- EQUIPMENT_TYPE
CREATE TABLE tblEQUIPMENT_TYPE (
    EquipmentTypeID INT IDENTITY PRIMARY KEY NOT NULL,
    EquipmentTypeName VARCHAR(50) NOT NULL,
    EquipmentTypeDesc VARCHAR(50)
);
GO

/*
Batch all foreign key definitions at end of DDL script (using ALTER TABLE statements for each FK)
*/
-- ALTER tblMEMBER
ALTER TABLE tblMEMBER 
ADD FOREIGN KEY (GymID) REFERENCES tblGYM(GymID);

-- ALTER tblCLASS
ALTER TABLE tblCLASS
ADD FOREIGN KEY (ClassTypeID) REFERENCES tblCLASS_TYPE(ClassTypeID),
    FOREIGN KEY (GymID) REFERENCES tblGYM(GymID);

-- ALTER tblCLASS_LIST
ALTER TABLE tblCLASS_LIST
ADD FOREIGN KEY (ClassID) REFERENCES tblCLASS(ClassID),
    FOREIGN KEY (MemberID) REFERENCES tblMEMBER(MemberID);

-- ALTER tblSTAFF
ALTER TABLE tblSTAFF
ADD FOREIGN KEY (StaffTypeID) REFERENCES tblSTAFF_TYPE(StaffTypeID),
    FOREIGN KEY (GymID) REFERENCES tblGYM(GymID);

-- ALTER tblEXERCISE
ALTER TABLE tblEXERCISE
ADD FOREIGN KEY (EquipmentID) REFERENCES tblEQUIPMENT(EquipmentID),
    FOREIGN KEY (ExerciseTypeID) REFERENCES tblEXERCISE_TYPE(ExerciseTypeID);

-- ALTER tblEXERCISE_LIST
ALTER TABLE tblEXERCISE_LIST
ADD FOREIGN KEY (ClassID) REFERENCES tblCLASS(ClassID),
    FOREIGN KEY (ExerciseID) REFERENCES tblEXERCISE(ExerciseID);

-- ALTER tblEQUIPMENT
ALTER TABLE tblEQUIPMENT
ADD FOREIGN KEY (EquipmentTypeID) REFERENCES tblEQUIPMENT_TYPE(EquipmentTypeID);
GO

/*
INSERT INTO statements (5 rows) for each table w/out a FK
*/
--tblCLASS_TYPE
BEGIN TRANSACTION InsertNoFK
INSERT INTO tblCLASS_TYPE VALUES('Yoga', 1.0)
INSERT INTO tblCLASS_TYPE VALUES('Weight Lifting', 1.5)
INSERT INTO tblCLASS_TYPE VALUES('Cardio', 1.0)
INSERT INTO tblCLASS_TYPE VALUES('Swimming', 2.0)
INSERT INTO tblCLASS_TYPE VALUES('CrossFit', 1.0)

--tblGYM
INSERT INTO tblGYM VALUES('Athlectic Club NW','1234 Main St','Seattle', 'Washington', '98134')
INSERT INTO tblGYM VALUES('Athletic Club Desert', '654 Valley Ave', 'Phoenix', 'Arizona', '85027')
INSERT INTO tblGYM VALUES('Athletic Club Rockies', '5280 Arvada Blvd', 'Denver', 'Colorado', '80011')
INSERT INTO tblGYM VALUES('Athletic Club Aloha', '923 Luau Blvd', 'Honolulu', 'Hawaii', '96814')
INSERT INTO tblGYM VALUES('Athletic Club East', '990 Constitution Way', 'Philadelphia', 'Pennsylvania', '19125')

--tblSTAFF_TYPE
INSERT INTO tblSTAFF_TYPE VALUES('Manager', 'Oversee all gym happenings')
INSERT INTO tblSTAFF_TYPE VALUES('Trainer', 'Assist members with training')
INSERT INTO tblSTAFF_TYPE VALUES('Receptionist', 'Manage phone calls and memberships')
INSERT INTO tblSTAFF_TYPE VALUES('Custodian', 'Clean gym floors and locker rooms')
INSERT INTO tblSTAFF_TYPE VALUES('Security', 'Keep the gym members safe')

--tblEXERCISE_TYPE
INSERT INTO tblEXERCISE_TYPE VALUES('Weights', 'Lifting heavy objects')
INSERT INTO tblEXERCISE_TYPE VALUES('Cardio', 'Cardiovascular exercise')
INSERT INTO tblEXERCISE_TYPE VALUES('Stretching', 'Enhancing flexibility')
INSERT INTO tblEXERCISE_TYPE VALUES('Calisthenics', 'Moving the body thru space')
INSERT INTO tblEXERCISE_TYPE VALUES('Skill', 'Performing a unique task')

--tblEQUIPMENT_TYPE
INSERT INTO tblEQUIPMENT_TYPE VALUES('Resistance Machine', 'Has adjustable settings for weightlifting')
INSERT INTO tblEQUIPMENT_TYPE VALUES('Free Weight', 'Weights not attached to machines')
INSERT INTO tblEQUIPMENT_TYPE VALUES('Cardio Machine', 'Machines for cardiovascular work')
INSERT INTO tblEQUIPMENT_TYPE VALUES('Accessory', 'Small items that aid with other machines')
INSERT INTO tblEQUIPMENT_TYPE VALUES('Apparel', 'Clothing specific to certain exercises')
INSERT INTO tblEQUIPMENT_TYPE VALUES('Bodyweight', 'No equipment, just your body')
COMMIT TRANSACTION InsertNoFK
GO

/*
All other INSERT statements
*/
-- tblMEMBER
BEGIN TRANSACTION InsertWithFK
INSERT INTO tblMEMBER VALUES('John', 'Doe', '43 Lynn Ave', 'Seattle', 'Washington', '98100', 1, 'jdoe@gmail.com')
INSERT INTO tblMEMBER VALUES('Jason', 'Terry', '7612 Amazon Circle', 'Scottsdale', 'Arizona', '85032', 2, 'jaytay@yahoo.com')
INSERT INTO tblMEMBER VALUES('Erica', 'Williams', '4122 Mile High Ave', 'Denver', 'Colorado', '80011', 3, 'girlygirl@gmail.com')
INSERT INTO tblMEMBER VALUES('Dwayne', 'Johnson', '100 Rock Road', 'Waikiki', 'Hawaii', '96833', 4, 'therock@me.com')
INSERT INTO tblMEMBER VALUES('Tobias', 'Harris', '2200 Sixer Blvd', 'Philadelphia', 'Pennsylvania', '19100', 5, 'harristoby@gmail.com')

--tblCLASS
INSERT INTO tblCLASS VALUES('Olympic Barbell', 2, '5:30am', '2023-02-28', 2)
INSERT INTO tblCLASS VALUES('Swimming With Sally', 4, '12:00pm', '2022-01-15', 5)
INSERT INTO tblCLASS VALUES('ChrisFit', 5, '7:00pm', '2021-07-25', 4)
INSERT INTO tblCLASS VALUES('Mile High Run Club', 3, '8:00am', '2023-09-16', 3)
INSERT INTO tblCLASS VALUES('Paddle Board Yoga', 1, '7:00pm', '2018-04-30', 1)

--tblCLASS_LIST
INSERT INTO tblCLASS_LIST VALUES(5, 1, 50.99) 
INSERT INTO tblCLASS_LIST VALUES(1, 2, 25.50)
INSERT INTO tblCLASS_LIST VALUES(4, 3, 30.25)
INSERT INTO tblCLASS_LIST VALUES(3, 4, 05.00)
INSERT INTO tblCLASS_LIST VALUES(2, 5, 10.00)

-- --tblSTAFF
INSERT INTO tblSTAFF VALUES('Jock', 'Arnold', 1, 1, '4456 Bothell St', 'Bothell', 'Washington', '98124', 35, 20.50)
INSERT INTO tblSTAFF VALUES('Amy', 'Lang', 2, 2, '756 Cactus Road', 'Scottsdale', 'Arizona', '85103', 40, 40.45)
INSERT INTO tblSTAFF VALUES('Ethan', 'Ericson', 2, 3, '534 Adams St', 'Aurora', 'Colorado', '81000', 40, 45.50)
INSERT INTO tblSTAFF VALUES('Karen', 'Gonzalez', 1, 4, '542 Aloha Blvd', 'Honolulu', 'Hawaii', '96023', 20, 21.50)
INSERT INTO tblSTAFF VALUES('Jessica', 'Rocci', 3, 5, '64 Bell Ave', 'Philadelphia', 'Pennsylvania', '19032', 25, 18.75)

--tblEQUIPMENT
INSERT INTO tblEQUIPMENT VALUES('Power Rack', 2)
INSERT INTO tblEQUIPMENT VALUES('Treadmill', 3)
INSERT INTO tblEQUIPMENT VALUES('Jump Rope', 4)
INSERT INTO tblEQUIPMENT VALUES('Dumbbells', 2)
INSERT INTO tblEQUIPMENT VALUES('Smith Machine', 1)
INSERT INTO tblEQUIPMENT VALUES('Hang Bar', 6)
INSERT INTO tblEQUIPMENT VALUES('No Equipment', 6)

--tblEXERCISE
INSERT INTO tblEXERCISE VALUES('Bench Press', 'Chest', 1, 1)
INSERT INTO tblEXERCISE VALUES('Squat', 'Legs', 1, 1)
INSERT INTO tblEXERCISE VALUES('Pull Ups', 'Back', 6, 4)
INSERT INTO tblEXERCISE VALUES('Curls', 'Biceps', 4, 1)
INSERT INTO tblEXERCISE VALUES('Sprints', 'Legs', 2, 2)

--tblEXERCISE_LIST
INSERT INTO tblEXERCISE_LIST VALUES(1, 1, 'Bench Press')
INSERT INTO tblEXERCISE_LIST VALUES(1, 2, 'Squat')
INSERT INTO tblEXERCISE_LIST VALUES(3, 3, 'Pull Ups')
INSERT INTO tblEXERCISE_LIST VALUES(3, 5, 'Sprints')
INSERT INTO tblEXERCISE_LIST VALUES(4, 5, 'Sprints')
COMMIT TRANSACTION InsertWithFK
GO

/*
STORED PROCEDURES
*/
-- procedure to insert a Member into a class
CREATE OR ALTER PROCEDURE uspInsertMemberToClass
@FirstName VARCHAR(50),
@LastName VARCHAR(50), 
@GymID INT,
@ClassName VARCHAR(50),
@RegFee NUMERIC
AS
DECLARE @M_ID INT, @C_ID INT
SET @M_ID = ( SELECT M.MemberID
            FROM tblMEMBER M 
            WHERE M.MemberFname = @FirstName
            AND M.MemberLname = @LastName
            AND M.GymID = @GymID)
            IF @M_ID IS NULL
                BEGIN 
                    PRINT 'MemberID is NULL, Please check parameters. Members can only enroll in classes provided at their home gym.'
                    RAISERROR ('@M_ID cannot be NULL. Process terminating.', 11, 1)
                    RETURN
                END
SET @C_ID = ( SELECT C.ClassID
            FROM tblCLASS C 
                JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
                JOIN tblMEMBER M ON CL.MemberID = M.MemberID
            WHERE C.GymID = @GymID
            AND C.ClassName = @ClassName)
            IF @M_ID IS NULL
                BEGIN 
                    PRINT 'ClassID is NULL, Please check parameters. Members can only enroll in classes provided at their home gym.'
                    RAISERROR ('@C_ID cannot be NULL. Process terminating.', 11, 1)
                    RETURN
                END
BEGIN TRANSACTION T1
INSERT INTO tblCLASS_LIST (ClassID, MemberID, RegistrationFee)
VALUES (@C_ID, @M_ID, @RegFee)
COMMIT TRANSACTION T1
GO
-- execute
EXEC uspInsertMemberToClass
@FirstName = 'Jason',
@LastName = 'Terry',
@GymID = 2,
@ClassName = 'Olympic Barbell',
@RegFee = 30
GO

SELECT M.MemberID, M.MemberFname, M.MemberLname, CL.ClassID, C.ClassName
FROM tblCLASS_LIST CL
    JOIN tblMEMBER M ON M.MemberID = CL.MemberID
    JOIN tblCLASS C ON C.ClassID = CL.ClassID
GO

-- procedure to insert a new exercise
CREATE OR ALTER PROCEDURE uspInsertNewExercise
@ExerciseName VARCHAR(50),
@MusclesWorked VARCHAR(50), 
@Equipment VARCHAR(50),
@ExerciseType VARCHAR(50)
AS
DECLARE @EQ_ID INT, @ET_ID INT -- EQ = equipment, ET = exercise type
SET @EQ_ID = (SELECT E.EquipmentID
            FROM tblEQUIPMENT E
            WHERE E.EquipmentName = @Equipment)
            IF @EQ_ID IS NULL
                BEGIN 
                    PRINT 'EquipmentID is NULL, Please check parameters.'
                    RAISERROR ('@EQ_ID cannot be NULL. Process terminating.', 11, 1)
                    RETURN
                END
SET @ET_ID = (SELECT ET.ExerciseTypeID
            FROM tblEXERCISE_TYPE ET
            WHERE ET.ExerciseTypeName = @ExerciseType)
            IF @EQ_ID IS NULL
                BEGIN 
                    PRINT 'ExerciseTypeID is NULL, Please check parameters.'
                    RAISERROR ('@ET_ID cannot be NULL. Process terminating.', 11, 1)
                    RETURN
                END
BEGIN TRANSACTION T2
INSERT INTO tblEXERCISE (ExerciseName, MusclesWorked, EquipmentID, ExerciseTypeID)
VALUES (@ExerciseName, @MusclesWorked, @EQ_ID, @ET_ID)
COMMIT TRANSACTION T2
GO
-- execute
EXEC uspInsertNewExercise
@ExerciseName = 'Handstand Push Up',
@MusclesWorked = 'Shoulders',
@Equipment = 'No Equipment',
@ExerciseType = 'Calisthenics'
GO

SELECT *
FROM tblEXERCISE
GO

/*
TRIGGERS
*/
-- trigger to record number of new members that are added to each gym location
-- (set up for trigger)
ALTER TABLE tblGYM
ADD MemberCount INT NOT NULL
DEFAULT (1) -- already one member in each gym
GO
-- trigger starts here
CREATE OR ALTER TRIGGER GymMemberInsert
ON tblMEMBER
AFTER INSERT, DELETE
AS 
IF EXISTS (SELECT * FROM Inserted) AND NOT EXISTS (SELECT * FROM Deleted)
BEGIN
    UPDATE tblGYM
        SET MemberCount += 1
        FROM Inserted
        WHERE tblGYM.GymID = Inserted.GymID
        PRINT 'adding to member count in tblGYM'
    ;
END
IF EXISTS (SELECT * FROM Deleted) AND NOT EXISTS (SELECT * FROM Inserted)
BEGIN
    UPDATE tblGYM
        SET MemberCount -= 1
        FROM Deleted
        WHERE tblGYM.GymID = Deleted.GymID
        PRINT 'removing from member count in tblGYM'
    ;
END
GO

INSERT INTO tblMEMBER VALUES('Kelly', 'Slater', '53 Surf Way', 'Honolulu', 'Hawaii', '96120', 4, 'kslater332@yahoo.com')
GO

SELECT *
FROM tblGYM
GO

-- trigger to protect rows in tblGYM from being deleted
CREATE OR ALTER TRIGGER GymLocationDelete
ON tblGYM
INSTEAD OF DELETE
AS
ROLLBACK
;
GO

/*
COMPUTED COLUMNS
*/
-- computed column to determine how much staff members earn per week
ALTER TABLE tblSTAFF ADD WeeklyPay AS (HoursPerWeek * PayRate);
GO

--computed column to determine how much each member pays in class registration fees
-- function to help with computed column
CREATE FUNCTION getTotalRegFees(@memberID INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT
    SET @total = (
        SELECT SUM(CL.RegistrationFee)
        FROM tblCLASS_LIST CL
            JOIN tblMEMBER M ON M.MemberID = CL.MemberID
        WHERE M.MemberID = @memberID
    )
    RETURN @total
END 
GO
-- compute column
ALTER TABLE tblMEMBER ADD TotalRegFees AS (dbo.getTotalRegFees(MemberID))
GO

/*
COMPLEX QUERIES
*/
-- find the exercises that use Free Weight equipment types and work the back muscles
SELECT EX.ExerciseID, EX.ExerciseName, EX.MusclesWorked, EQ.EquipmentName, EQT.EquipmentTypeName
FROM tblEXERCISE EX
    JOIN tblEQUIPMENT EQ ON EX.EquipmentID = EQ.EquipmentID
    JOIN tblEQUIPMENT_TYPE EQT ON EQ.EquipmentTypeID = EqT.EquipmentTypeID
WHERE EQT.EquipmentTypeName = 'Free Weight'
AND EX.MusclesWorked = 'Back'

-- determine which classes incorporate both Calisthenics and cardio in their workouts
SELECT C.ClassName
FROM tblCLASS C
    JOIN tblEXERCISE_LIST EXL ON C.ClassID = EXL.ClassID
    JOIN tblEXERCISE EX ON EXL.ExerciseID = EX.ExerciseID
    JOIN tblEXERCISE_TYPE EXT ON EX.ExerciseTypeID = EXT.ExerciseTypeID
    JOIN (
        SELECT C.ClassName
        FROM tblCLASS C
            JOIN tblEXERCISE_LIST EXL ON C.ClassID = EXL.ClassID
            JOIN tblEXERCISE EX ON EXL.ExerciseID = EX.ExerciseID
            JOIN tblEXERCISE_TYPE EXT ON EX.ExerciseTypeID = EXT.ExerciseTypeID
        WHERE EXT.ExerciseTypeName = 'Cardio'
    ) AS subq1 ON C.ClassName = subq1.ClassName
WHERE EXT.ExerciseTypeName = 'Calisthenics'
