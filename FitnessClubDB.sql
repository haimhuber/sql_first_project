------------------------------------------
-- HOW TO DROP DB, 
--  IN CASE YOU WANT TO COMPLETELY DELETE IT
-- 1) JUST DROP IT
use master
GO
DROP DATABASE FitnessClubDB

-- OR:
-- 2) CLOSE ALL CONNECTIONS AND THEN DROP IT
USE master;
GO
ALTER DATABASE FitnessClubDB 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE FitnessClubDB;
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
INSERT INTO Members (fullName, email, phoneNumber, dateOfBirth) VALUES
('John Doe', 'john.doe@example.com', '555-1234', '1990-05-14'),
('Jane Smith', 'jane.smith@example.com', '555-5678', '1985-08-22'),
('Michael Johnson', 'michael.johnson@example.com', '555-8765', '1992-03-11'),
('Emily Davis', 'emily.davis@example.com', '555-4321', '1988-01-25'),
('Chris Lee', 'chris.lee@example.com', '555-6789', '1995-09-10'),
('Sarah Brown', 'sarah.brown@example.com', '555-2345', '1990-12-05'),
('David Wilson', 'david.wilson@example.com', '555-3456', '1987-06-13'),
('Laura Martin', 'laura.martin@example.com', '555-4567', '1993-02-20'),
('Matthew Moore', 'matthew.moore@example.com', '555-5679', '1980-07-30'),
('Olivia Taylor', 'olivia.taylor@example.com', '555-6780', '1996-11-03'),
('James Anderson', 'james.anderson@example.com', '555-7890', '1989-04-12'),
('Hannah Thomas', 'hannah.thomas@example.com', '555-8901', '1994-10-25'),
('Daniel Jackson', 'daniel.jackson@example.com', '555-9012', '1991-02-15'),
('Sophia White', 'sophia.white@example.com', '555-0123', '1986-09-08'),
('William Harris', 'william.harris@example.com', '555-1235', '1984-03-19'),
('Abigail Clark', 'abigail.clark@example.com', '555-2346', '1993-06-17'),
('Ethan Lewis', 'ethan.lewis@example.com', '555-3457', '1998-01-30'),
('Chloe Robinson', 'chloe.robinson@example.com', '555-4568', '1987-12-09'),
('Benjamin Walker', 'benjamin.walker@example.com', '555-5670', '1990-05-21'),
('Avery Young', 'avery.young@example.com', '555-6781', '1982-04-02'),
('Megan King', 'megan.king@example.com', '555-7891', '1989-07-07'),
('Lucas Scott', 'lucas.scott@example.com', '555-8902', '1996-12-12'),
('Grace Adams', 'grace.adams@example.com', '555-9013', '1997-11-11'),
('Jacob Nelson', 'jacob.nelson@example.com', '555-0124', '1985-02-28'),
('Madison Carter', 'madison.carter@example.com', '555-1236', '1991-08-10'),
('Evan Mitchell', 'evan.mitchell@example.com', '555-2347', '1983-10-22'),
('Zoe Perez', 'zoe.perez@example.com', '555-3458', '1992-07-18'),
('Mason Roberts', 'mason.roberts@example.com', '555-4569', '1994-12-01'),
('Isabella Gonzalez', 'isabella.gonzalez@example.com', '555-5671', '1995-05-16'),
('Samuel Moore', 'samuel.moore@example.com', '555-6782', '1990-01-29'),
('Victoria White', 'victoria.white@example.com', '555-7892', '1992-11-07'),
('Aidan Martinez', 'aidan.martinez@example.com', '555-8903', '1988-02-19');


GO

/* TrainersDetails */
INSERT INTO TrainersDetails (fullName, phoneNumber, address, age, height, weight) VALUES
('John Smith', '555-1111', '123 Oak Street, Springfield', 30, 180, 75),
('Emily Johnson', '555-1112', '456 Pine Avenue, Springfield', 28, 165, 60),
('Michael Williams', '555-1113', '789 Maple Drive, Springfield', 35, 178, 85),
('Sarah Davis', '555-1114', '101 Birch Lane, Springfield', 32, 170, 68),
('Chris Brown', '555-1115', '202 Cedar Road, Springfield', 29, 176, 72),
('Jessica Miller', '555-1116', '303 Elm Street, Springfield', 26, 162, 58),
('David Wilson', '555-1117', '404 Oak Avenue, Springfield', 40, 185, 95),
('Olivia Moore', '555-1118', '505 Pine Lane, Springfield', 38, 167, 65),
('Daniel Taylor', '555-1119', '606 Maple Avenue, Springfield', 33, 172, 78),
('Sophia Anderson', '555-1120', '707 Birch Road, Springfield', 27, 168, 64),
('James Thomas', '555-1121', '808 Cedar Street, Springfield', 31, 180, 80),
('Megan Jackson', '555-1122', '909 Elm Avenue, Springfield', 29, 173, 70),
('Lucas White', '555-1123', '1010 Oak Street, Springfield', 25, 177, 76),
('Isabella Harris', '555-1124', '1111 Pine Road, Springfield', 34, 165, 63),
('Ethan Martin', '555-1125', '1212 Maple Lane, Springfield', 37, 182, 85),
('Chloe Lee', '555-1126', '1313 Birch Avenue, Springfield', 26, 160, 55),
('Benjamin Scott', '555-1127', '1414 Cedar Lane, Springfield', 40, 174, 80),
('Avery Young', '555-1128', '1515 Elm Road, Springfield', 32, 169, 67),
('Liam Allen', '555-1129', '1616 Oak Avenue, Springfield', 27, 178, 73),
('Victoria King', '555-1130', '1717 Pine Street, Springfield', 30, 160, 58),
('Samuel Wright', '555-1131', '1818 Maple Street, Springfield', 35, 180, 82),
('Mason Perez', '555-1132', '1919 Birch Lane, Springfield', 28, 175, 70),
('Zoe Gonzalez', '555-1133', '2020 Cedar Avenue, Springfield', 31, 160, 59),
('Jack Carter', '555-1134', '2121 Elm Street, Springfield', 34, 185, 90),
('Madison Mitchell', '555-1135', '2222 Oak Road, Springfield', 29, 168, 62),
('Gabriel Adams', '555-1136', '2323 Pine Avenue, Springfield', 33, 177, 75),
('Charlotte Nelson', '555-1137', '2424 Maple Avenue, Springfield', 36, 163, 65),
('Wyatt Turner', '555-1138', '2525 Birch Street, Springfield', 39, 180, 88),
('Lily Roberts', '555-1139', '2626 Cedar Street, Springfield', 30, 170, 66),
('Elijah Clark', '555-1140', '2727 Elm Lane, Springfield', 27, 175, 74),
('Harper Martinez', '555-1141', '2828 Oak Lane, Springfield', 28, 162, 60);

GO
/* --------------------------------------------------------- */

/* TrainerSpecialization */
INSERT INTO TrainerSpecialization (trainerId, specialization, startExperienceDate) VALUES
(1, 'Strength Training', '2015-06-01'),
(2, 'Cardio Training', '2017-08-15'),
(3, 'Yoga', '2014-03-20'),
(4, 'Pilates', '2016-09-10'),
(5, 'HIIT', '2015-01-25'),
(6, 'Strength Training', '2018-07-05'),
(7, 'CrossFit', '2016-04-18'),
(8, 'Weight Loss Coaching', '2017-05-11'),
(9, 'Mobility Training', '2014-11-02'),
(10, 'Personal Training', '2019-02-01'),
(11, 'Boxing', '2016-10-10'),
(12, 'Strength Training', '2015-12-20'),
(13, 'Yoga', '2018-06-15'),
(14, 'Sports Nutrition', '2017-01-22'),
(15, 'Cardio Training', '2019-09-09'),
(16, 'Personal Training', '2014-07-19'),
(17, 'Pilates', '2017-03-01'),
(18, 'HIIT', '2016-06-11'),
(19, 'Functional Fitness', '2015-04-25'),
(20, 'Strength Training', '2014-10-30'),
(21, 'Weight Loss Coaching', '2018-02-10'),
(22, 'CrossFit', '2017-08-01'),
(23, 'Boxing', '2019-07-07'),
(24, 'Mobility Training', '2016-11-05'),
(25, 'Sports Nutrition', '2015-09-17'),
(26, 'Personal Training', '2014-01-14'),
(27, 'Yoga', '2019-11-22'),
(28, 'HIIT', '2017-05-05'),
(29, 'Strength Training', '2016-03-01'),
(30, 'Functional Fitness', '2015-12-12');
/* Second */
(1, 'Functional Fitness', '2016-05-10'),
(2, 'Sports Nutrition', '2018-03-12'),
(3, 'Boxing', '2014-08-23'),
(4, 'Cardio Training', '2017-09-17'),
(5, 'Pilates', '2019-04-20'),
(6, 'Weight Loss Coaching', '2015-11-11'),
(7, 'Yoga', '2016-02-19'),
(8, 'Strength Training', '2019-06-01'),
(9, 'HIIT', '2017-07-10'),
(10, 'Personal Training', '2018-08-15'),
(11, 'Boxing', '2015-01-08'),
(12, 'Sports Nutrition', '2017-11-05'),
(13, 'Yoga', '2014-05-25'),
(14, 'Strength Training', '2016-12-01'),
(15, 'CrossFit', '2019-03-02'),
(16, 'Mobility Training', '2015-06-15'),
(17, 'Personal Training', '2016-09-22'),
(18, 'HIIT', '2018-04-11'),
(19, 'Cardio Training', '2017-01-30'),
(20, 'Functional Fitness', '2015-08-19'),
(21, 'Strength Training', '2016-02-28'),
(22, 'Pilates', '2018-07-13'),
(23, 'Boxing', '2019-01-07'),
(24, 'Sports Nutrition', '2014-09-12'),
(25, 'CrossFit', '2015-03-03'),
(26, 'Mobility Training', '2017-06-10'),
(27, 'Weight Loss Coaching', '2016-10-25'),
(28, 'Personal Training', '2018-01-10'),
(29, 'Functional Fitness', '2019-05-15'),
(30, 'Strength Training', '2017-04-02');
/* Third */
(1, 'CrossFit', '2015-04-01'),
(2, 'Strength Training', '2016-11-23'),
(3, 'HIIT', '2017-05-17'),
(4, 'Mobility Training', '2018-02-05'),
(5, 'Cardio Training', '2019-01-12'),
(6, 'Sports Nutrition', '2015-03-10'),
(7, 'Weight Loss Coaching', '2017-10-04'),
(8, 'Boxing', '2018-08-23'),
(9, 'Yoga', '2016-07-18'),
(10, 'Personal Training', '2015-09-28'),
(11, 'Strength Training', '2014-10-05'),
(12, 'HIIT', '2019-06-07'),
(13, 'Pilates', '2016-02-03'),
(14, 'Mobility Training', '2018-04-21'),
(15, 'Functional Fitness', '2019-03-10'),
(16, 'Sports Nutrition', '2017-01-11'),
(17, 'Cardio Training', '2015-11-14'),
(18, 'Weight Loss Coaching', '2016-12-05'),
(19, 'CrossFit', '2017-07-02'),
(20, 'Boxing', '2019-02-19'),
(21, 'Strength Training', '2014-06-15'),
(22, 'Yoga', '2018-10-28'),
(23, 'HIIT', '2017-09-14'),
(24, 'Pilates', '2015-01-02'),
(25, 'Functional Fitness', '2016-08-29'),
(26, 'CrossFit', '2019-04-23'),
(27, 'Sports Nutrition', '2014-05-06'),
(28, 'Personal Training', '2017-12-18'),
(29, 'Mobility Training', '2015-12-01'),
(30, 'Boxing', '2018-11-30');


GO

/* WorkoutPlans */
INSERT INTO WorkoutPlans (trainerId, planName, description, freqPerWeek, price) VALUES
(1, 'Strength Training Program', 'A comprehensive strength training plan focused on building muscle and increasing strength.', 3, 200.00),
(2, 'Cardio Blast', 'High-intensity cardio workouts designed for fat loss and cardiovascular health.', 5, 150.00),
(3, 'Yoga for Flexibility', 'A yoga program aimed at improving flexibility, mobility, and reducing stress.', 2, 120.00),
(4, 'Pilates for Core Strength', 'Pilates classes designed to strengthen your core and improve posture.', 3, 180.00),
(5, 'HIIT for Weight Loss', 'Intense HIIT workouts for those looking to lose weight and boost their metabolism.', 4, 210.00),
(6, 'Beginner Strength Training', 'A beginner-friendly program to get started with weight training and build basic strength.', 2, 140.00),
(7, 'CrossFit Conditioning', 'CrossFit-inspired program to improve overall fitness, strength, and endurance.', 4, 220.00),
(8, 'Weight Loss and Toning', 'A program focused on weight loss, muscle toning, and overall body sculpting.', 5, 160.00),
(9, 'Mobility and Stretching', 'A plan focused on improving joint mobility and flexibility through stretches and movements.', 2, 110.00),
(10, 'Personal Training Program', 'One-on-one personal training focusing on personalized goals and progress tracking.', 2, 250.00),
(11, 'Boxing for Fitness', 'Boxing-inspired workouts to improve cardiovascular health and upper body strength.', 3, 180.00),
(12, 'Advanced Strength Training', 'An advanced strength training program designed for experienced lifters looking to push their limits.', 3, 250.00),
(13, 'Mindful Yoga', 'A yoga program focusing on mental well-being, mindfulness, and relaxation.', 2, 130.00),
(14, 'Sports Nutrition and Fitness', 'Combines fitness training with expert nutritional guidance for optimal performance.', 3, 200.00),
(15, 'Cardio and Core', 'A program designed to improve cardiovascular health while strengthening the core muscles.', 4, 170.00),
(16, 'Functional Training Program', 'A program designed to enhance everyday movement and overall body function.', 3, 190.00),
(17, 'Pilates Reformer Classes', 'Pilates reformer sessions designed to target core muscles and improve posture.', 2, 160.00),
(18, 'Advanced HIIT Training', 'A high-intensity interval training program for experienced athletes focused on endurance and strength.', 5, 240.00),
(19, 'Weight Loss and Conditioning', 'A program combining weight loss strategies with overall body conditioning and toning.', 4, 180.00),
(20, 'Speed and Agility Training', 'A program aimed at improving athletic performance through speed and agility drills.', 3, 210.00),
(21, 'Strength and Conditioning', 'A program combining strength training with conditioning exercises for total fitness.', 4, 200.00),
(22, 'CrossFit Strength and Conditioning', 'A CrossFit-based strength and conditioning program for overall fitness improvement.', 4, 230.00),
(23, 'Yoga and Mindfulness', 'A calming yoga program focusing on relaxation, flexibility, and mental clarity.', 2, 150.00),
(24, 'Running Endurance Program', 'A running-specific program designed to improve endurance, speed, and running efficiency.', 3, 180.00),
(25, 'Senior Fitness Program', 'A fitness plan tailored for seniors, focusing on mobility, strength, and overall well-being.', 2, 130.00),
(26, 'Teen Fitness Program', 'A fitness program designed specifically for teenagers to build strength and endurance in a safe way.', 3, 160.00),
(27, 'Core and Flexibility', 'A plan that focuses on strengthening the core and increasing flexibility through various exercises.', 3, 150.00),
(28, 'Athletic Conditioning', 'A high-intensity program aimed at conditioning athletes for peak performance.', 4, 210.00),
(29, 'Personal Weight Loss Plan', 'Customized weight loss plan with a combination of cardio, strength training, and nutrition guidance.', 5, 220.00),
(30, 'Powerlifting Program', 'A powerlifting-focused program designed to maximize strength in the squat, bench press, and deadlift.', 3, 230.00);
(1, 'Bodybuilding Program', 'A comprehensive bodybuilding plan focused on muscle hypertrophy and strength gains.', 4, 250.00),
(2, 'Total Body Conditioning', 'A full-body conditioning program to enhance strength, endurance, and flexibility.', 3, 190.00),
(3, 'Power Yoga', 'An intense yoga program combining strength, flexibility, and cardio to improve overall fitness.', 2, 140.00),
(4, 'Rehabilitation Program', 'A program designed for rehabilitation of injuries, focusing on safe exercises for recovery.', 2, 120.00),
(5, 'Advanced HIIT', 'An advanced high-intensity interval training program designed for fat loss and athletic conditioning.', 5, 220.00),
(6, 'Strength Training for Women', 'A strength training program tailored specifically for women looking to build lean muscle and strength.', 3, 180.00),
(7, 'CrossFit for Beginners', 'A CrossFit program designed for beginners looking to improve strength, endurance, and conditioning.', 4, 210.00),
(8, 'Low-Impact Fitness', 'A low-impact fitness program suitable for beginners or those recovering from injury.', 3, 160.00),
(9, 'Athletic Performance Training', 'A performance training program designed to improve athletic skills, speed, and agility.', 4, 230.00),
(10, 'Endurance Training Program', 'A program focusing on improving cardiovascular endurance and stamina through running and cycling.', 3, 190.00),
(11, 'Core Strength and Stability', 'A focused core training plan designed to build core strength, stability, and improve posture.', 3, 150.00),
(12, 'Senior Strength Program', 'A strength training program specifically designed for seniors to maintain muscle and bone health.', 2, 120.00),
(13, 'Sports-Specific Conditioning', 'Conditioning tailored to a specific sport to enhance performance and prevent injuries.', 3, 210.00),
(14, 'Functional Movement Training', 'A functional training program focusing on exercises that mimic everyday movements and improve mobility.', 4, 200.00),
(15, 'HIIT and Strength Fusion', 'A fusion of high-intensity interval training and strength training for maximum fat loss and muscle gain.', 5, 250.00),
(16, 'Total Body Sculpt', 'A program designed to sculpt and tone the entire body with a mix of strength, endurance, and mobility exercises.', 3, 170.00),
(17, 'Circuit Training Program', 'A full-body circuit training plan to build strength, endurance, and overall fitness.', 4, 180.00),
(18, 'Recovery and Mobility Plan', 'A recovery-focused plan to help athletes improve mobility and speed up recovery post-workout.', 2, 130.00),
(19, 'Weight Loss Bootcamp', 'An intense, fat-burning bootcamp program that combines strength and cardio workouts to help lose weight fast.', 5, 240.00),
(20, 'Powerlifting Strength Program', 'A program designed to improve your strength in the squat, bench press, and deadlift for powerlifters.', 4, 230.00),
(21, 'Functional Fitness for Athletes', 'A functional fitness program for athletes focusing on agility, speed, and explosive power.', 3, 210.00),
(22, 'Flexibility and Mobility Training', 'A program dedicated to increasing flexibility and mobility to enhance range of motion and reduce injury.', 2, 140.00),
(23, 'Youth Sports Conditioning', 'A conditioning program for young athletes to build strength, coordination, and speed.', 3, 180.00),
(24, 'Speed and Agility Drills', 'A program focusing on improving speed, agility, and quickness for athletes in all sports.', 4, 200.00),
(25, 'Boxing Fitness Program', 'A boxing fitness program combining cardiovascular training with strength and boxing techniques.', 3, 170.00),
(26, 'Mindfulness and Movement', 'A plan combining yoga, breathing exercises, and mindfulness practices to reduce stress and improve well-being.', 2, 160.00),
(27, 'Sports Recovery Program', 'A program designed to enhance muscle recovery and prevent injuries using stretching, mobility work, and recovery techniques.', 2, 130.00),
(28, 'Bootcamp Fitness', 'A bootcamp-style fitness program designed to push participants to their limits while building strength and endurance.', 5, 220.00),
(29, 'Strength Training for Runners', 'A strength program designed for runners to help improve performance and reduce injury risk.', 3, 180.00),
(30, 'Hybrid Fitness Program', 'A hybrid fitness plan combining strength training, HIIT, and flexibility to create a balanced fitness routine.', 4, 200.00);
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
