------------------------------------------
-- HOW TO DROP DB, 
--  IN CASE YOU WANT TO COMPLETELY DELETE IT
-- 1) JUST DROP IT
use master
GO
DROP DATABASE PizzaDB

-- OR:
-- 2) CLOSE ALL CONNECTIONS AND THEN DROP IT
USE master;
GO
ALTER DATABASE PizzaDB 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE PizzaDB;
------------------------------------------


-- Create a new database called 'PizzaDB'
-- Connect to the 'master' database to run this snippet
USE master
GO


-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'FitnessClubDB'
)
CREATE DATABASE FitnessClubDB;
GO


USE FitnessClubDB;
GO


	/*------------   Create tables   --------------*/

	CREATE TABLE Members (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		fullName varchar(255) NOT NULL,
		email varchar(255)UNIQUE NOT NULL,
		phoneNumber varchar(15) NOT NULL,
		dateOfBirth DATE NOT NULL,
		joinDate DATE DEFAULT GETDATE()
	);

	CREATE TABLE TrainersDetails
	 (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		fullName varchar(255) NOT NULL,
		phoneNumber varchar(15) NOT NULL,
		address VARCHAR(255) NOT NULL,
		age INT NOT NULL CHECK (age  >= 18),
		height INT NOT NULL,
		weight INT NOT NULL
	);


	CREATE TABLE TrainerSpecialization
	 (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		trainerId INT,
		specialization VARCHAR(255) NOT NULL,
		startExperienceDate DATE NOT NULL,
		FOREIGN KEY (trainerId) REFERENCES TrainersDetails(id)	
	);


	CREATE TABLE WorkoutPlans
	 (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		trainerId INT NOT NULL,
		planName varchar(255) NOT NULL,
		description varchar(1000),
		freqPerWeek INT NOT NULL CHECK (durationWeeks > 0 ) ,
		price DECIMAL(10,2) NOT NULL,
		FOREIGN KEY (trainerId) REFERENCES TrainersDetails(id)
	);

	CREATE TABLE RegistrationToWorkoutPlans
	 (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		memberId INT NOT NULL,
		planId INT NOT NULL,
		startDate DATE DEFAULT GETDATE(),
		FOREIGN KEY (memberId) REFERENCES Members(id),
		FOREIGN KEY (planId) REFERENCES WorkoutPlans(id)
	);

	CREATE TABLE PaymentsDetails
	 (
		id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		registrationId INT NOT NULL,
		amount DECIMAL NOT NULL,
		paymentMethods  VARCHAR(255) NOT NULL check (paymentMethods IN ('Credit Card', 'Paypal', 'Bank Transfer', 'Google Pay', 'Apple Pay')),
		paymentVerification  VARCHAR(255) NOT NULL,
		FOREIGN KEY (registrationId) REFERENCES RegistrationToWorkoutPlans(id)
	);

	GO

/* ------------------------ Insert Data into Tables -------------------- */
/* Members */

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Haim Or Huber', 'haimhuber90@gmail.com', '053-3351459', '1991-01-06');

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Yotam Alter', 'yotamalter90@gmail.com', '052-2251458', '1990-04-07');

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Johnny Talbatzh', 'johnnytalbatzh90@gmail.com', '051-1111111', '1992-03-21');

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Chen Taka', 'chentaka90@gmail.com', '050-2354689', '1993-12-23');

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Darth Vader', 'darthvader93@gmail.com', '04-6291025', '1889-02-24');

INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Obi-Wan Kenobi', 'obiwan93@gmail.com', '034-6291025', '1969-07-21');


INSERT INTO Members(fullName, email, phoneNumber, dateOfBirth)
VALUES ('Mufasa', 'mooo93@gmail.com', '012-3451025', '1990-01-22');

GO

/* TrainersDetails */
INSERT INTO TrainersDetails VALUES ('The Rock', '0523214567', 'Hollywood', 45, 185, 85);
INSERT INTO TrainersDetails VALUES ('The Mountain', '0511456879', 'Iceland', 31, 205, 120);
INSERT INTO TrainersDetails VALUES ('Mat Fraser', '0598748954', 'Vermont - USA', 33, 165, 84);
INSERT INTO TrainersDetails VALUES ('Daniel brandon', '0539845123', 'Wisconsin - USA', 28, 160, 51);
INSERT INTO TrainersDetails VALUES ('Lara croft', '0502145698', 'Surrey - England', 39, 159, 49);
GO
/* --------------------------------------------------------- */

/* TrainerSpecialization */
INSERT INTO TrainerSpecialization VALUES (1, 'Weights Training', 7);
INSERT INTO TrainerSpecialization VALUES (1, 'Bodybuilding', 6);
INSERT INTO TrainerSpecialization VALUES (1, 'Speed strength', 4);
INSERT INTO TrainerSpecialization VALUES (2, 'Isometric weight training', 5);
INSERT INTO TrainerSpecialization VALUES (2, 'Push-pull training', 3);
INSERT INTO TrainerSpecialization VALUES (2, 'Muscular isolation', 2);
INSERT INTO TrainerSpecialization VALUES (3, 'Weightlifting', 3);
INSERT INTO TrainerSpecialization VALUES (3, 'Powerlifting', 3);
INSERT INTO TrainerSpecialization VALUES (3, 'CrossFit', 7);
INSERT INTO TrainerSpecialization VALUES (3, 'Explosive strength', 2);
INSERT INTO TrainerSpecialization VALUES (4, 'Power Cyclic', 3);
INSERT INTO TrainerSpecialization VALUES (4, 'Endurance', 4);
INSERT INTO TrainerSpecialization VALUES (5, 'Agility', 6);
INSERT INTO TrainerSpecialization VALUES (5, 'Gymnastic', 4);
INSERT INTO TrainerSpecialization VALUES (5, 'Cardiovascular/Respiratory', 2);
GO

/* WorkoutPlans */
INSERT INTO WorkoutPlans VALUES (1, 'Max weights trainnig', 'Maximum weight on the bar to acehive maximum capacity', 2, 100);
INSERT INTO WorkoutPlans VALUES (1, 'Max Deadlift', 'Maximum Deadlift in 30 min', 2, 90);
INSERT INTO WorkoutPlans VALUES (2, 'ISO', 'Make your body equal', 3, 50);
INSERT INTO WorkoutPlans VALUES (2, 'EMOM', 'Every Minute On The Monute', 3, 30);
INSERT INTO WorkoutPlans VALUES (3, 'CWL', 'Cyclic Weight Lifting', 1, 30);
INSERT INTO WorkoutPlans VALUES (3, 'TABATA', 'Tabata Cyclic Trainnig', 1, 50);
INSERT INTO WorkoutPlans VALUES (4, 'Power Cyclic', 'Power Training', 2, 75);
INSERT INTO WorkoutPlans VALUES (4, 'Endurance', 'Long run', 3, 120);
INSERT INTO WorkoutPlans VALUES (4, 'Stamina', 'Long runs', 1, 20);
INSERT INTO WorkoutPlans VALUES (4, 'Strength', 'Lifting heavy stuff', 2, 60);
INSERT INTO WorkoutPlans VALUES (5, 'Shooting', 'Shot on targets', 2, 160);
INSERT INTO WorkoutPlans VALUES (5, 'RFE', 'Run From Enemy', 1, 20);
GO


/* Payments */

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (1, 1);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (1, 2);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (1, 4);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (2, 2);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (2, 3);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (3, 1);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (3, 3);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (3, 2);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (4, 7);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (4, 8);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (4, 9);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (4, 2);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (5, 1);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (5, 11);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (5, 12);

INSERT INTO RegistrationToWorkoutPlans(memberId, planId)
VALUES (5, 10);

GO


/* PaymentsDetails fill the amount!!!! */

INSERT INTO PaymentsDetails VALUES (1, 'Credit Card', '485012345698794');
INSERT INTO PaymentsDetails VALUES (2, 'PayPal', '145879645213654');
INSERT INTO PaymentsDetails VALUES (3, 'Bank Transfer', '1478523690213654');
INSERT INTO PaymentsDetails VALUES (4, 'Credit Card', '53268478659541245');
INSERT INTO PaymentsDetails VALUES (5, 'PayPal', '114477885522656');
INSERT INTO PaymentsDetails VALUES (6, 'PayPal', '5522656');
INSERT INTO PaymentsDetails VALUES (7, 'Bank Transfer', '363698987474545412');
INSERT INTO PaymentsDetails VALUES (8, 'Bank Transfer', '363674545412');
INSERT INTO PaymentsDetails VALUES (9, 'PayPal', '5522656');
INSERT INTO PaymentsDetails VALUES (10, 'Credit Card', '458745487845645');
INSERT INTO PaymentsDetails VALUES (11, 'Credit Card', '14587945877445');
INSERT INTO PaymentsDetails VALUES (12, 'Google Pay', 'Galaxy S25');
INSERT INTO PaymentsDetails VALUES (13, 'Apple Pay', 'Iphone 15');
INSERT INTO PaymentsDetails VALUES (14, 'Google Pay', 'Pixel 9 Pro');
INSERT INTO PaymentsDetails VALUES (15, 'Credit Card', '5522656');
INSERT INTO PaymentsDetails VALUES (16, 'Google Pay', 'Motorola Moto 6 G');
GO
