-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               PostgreSQL 14.1, compiled by Visual C++ build 1914, 64-bit
-- Server OS:                    
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping data for table public.application: -1 rows
/*!40000 ALTER TABLE "application" DISABLE KEYS */;
INSERT INTO "application" ("application_id", "skill_level", "person_id", "parent_id", "instrument_id") VALUES
	(4, 1, 2, 1, 7),
	(6, 1, 5, 1, 4),
	(8, 1, 11, NULL, 7),
	(10, 1, 13, NULL, 4);
/*!40000 ALTER TABLE "application" ENABLE KEYS */;

-- Dumping data for table public.booking: -1 rows
/*!40000 ALTER TABLE "booking" DISABLE KEYS */;
INSERT INTO "booking" ("booking_id", "date", "instructor_id", "individual_lesson_id") VALUES
	(1, '2022-02-10 15:00:00', 1, 6),
	(2, '2022-03-04 14:30:00', 1, 9),
	(4, '2022-04-08 17:30:00', 1, 10),
	(5, '2022-10-19 20:00:00', 1, 11);
/*!40000 ALTER TABLE "booking" ENABLE KEYS */;

-- Dumping data for table public.ensemble: -1 rows
/*!40000 ALTER TABLE "ensemble" DISABLE KEYS */;
INSERT INTO "ensemble" ("group_lesson_id", "target_genre") VALUES
	(2, 'Gospel'),
	(4, 'Gospel'),
	(7, 'Gospel'),
	(15, 'Gospel'),
	(21, 'Gospel'),
	(25, 'Gospel'),
	(28, 'Soul');
/*!40000 ALTER TABLE "ensemble" ENABLE KEYS */;

-- Dumping data for table public.group_lesson: -1 rows
/*!40000 ALTER TABLE "group_lesson" DISABLE KEYS */;
INSERT INTO "group_lesson" ("group_lesson_id", "lesson_id", "min_num_of_students_requirement", "max_num_of_students_limit", "skill_level") VALUES
	(1, 2, 2, 6, 1),
	(2, 5, 2, 6, 1),
	(4, 6, 2, 6, 1),
	(5, 7, 2, 6, 1),
	(7, 20, 2, 6, 1),
	(9, 23, 2, 6, 1),
	(6, 17, 2, 6, 1),
	(10, 25, 2, 6, 1),
	(11, 26, 2, 6, 1),
	(12, 27, 2, 6, 1),
	(13, 29, 2, 6, 1),
	(14, 30, 2, 6, 1),
	(15, 34, 2, 6, 1),
	(16, 35, 2, 6, 1),
	(18, 36, 2, 6, 1),
	(21, 39, 2, 6, 1),
	(22, 47, 2, 6, 1),
	(23, 50, 2, 6, 1),
	(24, 51, 2, 6, 1),
	(25, 53, 2, 6, 1),
	(26, 54, 2, 6, 1),
	(27, 55, 2, 6, 1),
	(28, 57, 2, 6, 1);
/*!40000 ALTER TABLE "group_lesson" ENABLE KEYS */;

-- Dumping data for table public.individual_lesson: -1 rows
/*!40000 ALTER TABLE "individual_lesson" DISABLE KEYS */;
INSERT INTO "individual_lesson" ("individual_lesson_id", "lesson_id", "student_id", "instrument_id") VALUES
	(6, 12, 2, 4),
	(9, 21, 2, 4),
	(10, 22, 2, 4),
	(11, 45, 2, 4);
/*!40000 ALTER TABLE "individual_lesson" ENABLE KEYS */;

-- Dumping data for table public.instructor: -1 rows
/*!40000 ALTER TABLE "instructor" DISABLE KEYS */;
INSERT INTO "instructor" ("instructor_id", "hourly_salary", "person_id") VALUES
	(3, 186, 10),
	(4, 183, 9),
	(1, 182, 6);
/*!40000 ALTER TABLE "instructor" ENABLE KEYS */;

-- Dumping data for table public.instrument: -1 rows
/*!40000 ALTER TABLE "instrument" DISABLE KEYS */;
INSERT INTO "instrument" ("instrument_id", "name_of_instrument") VALUES
	(1, 'Guitar'),
	(2, 'Piano'),
	(3, 'Drums'),
	(4, 'Saxophone'),
	(5, 'Violin'),
	(6, 'Trumpet'),
	(7, 'Clarinet');
/*!40000 ALTER TABLE "instrument" ENABLE KEYS */;

-- Dumping data for table public.instrument_learning: -1 rows
/*!40000 ALTER TABLE "instrument_learning" DISABLE KEYS */;
INSERT INTO "instrument_learning" ("skill_level", "instrument_id", "student_id") VALUES
	(1, 7, 1),
	(1, 4, 2),
	(1, 7, 3),
	(1, 4, 4);
/*!40000 ALTER TABLE "instrument_learning" ENABLE KEYS */;

-- Dumping data for table public.instrument_taught: -1 rows
/*!40000 ALTER TABLE "instrument_taught" DISABLE KEYS */;
INSERT INTO "instrument_taught" ("instrument_id", "instructor_id") VALUES
	(4, 1),
	(7, 1),
	(4, 3),
	(7, 4);
/*!40000 ALTER TABLE "instrument_taught" ENABLE KEYS */;

-- Dumping data for table public.lesson: -1 rows
/*!40000 ALTER TABLE "lesson" DISABLE KEYS */;
INSERT INTO "lesson" ("lesson_id", "start_time", "number_of_hours", "venue_id", "instructor_id") VALUES
	(2, '2022-01-25 18:00:00', 1, 1, 1),
	(5, '2022-04-25 18:00:00', 1, 1, 1),
	(6, '2022-07-25 18:00:00', 1, 1, 1),
	(7, '2022-10-25 18:00:00', 1, 1, 1),
	(12, '2022-02-10 15:00:00', 1, 4, 1),
	(17, '2022-01-04 14:30:00', 1, 1, 1),
	(20, '2022-01-08 15:30:00', 1, 3, 1),
	(21, '2022-03-04 14:30:00', 1, 4, 1),
	(22, '2022-03-08 17:30:00', 1, 1, 1),
	(23, '2022-05-05 15:00:00', 1, 1, 1),
	(25, '2022-05-06 10:00:00', 1, 3, 1),
	(26, '2022-05-01 15:00:00', 1, 3, 1),
	(27, '2022-09-02 14:00:00', 1, 1, 1),
	(29, '2022-09-03 14:00:00', 1, 1, 1),
	(30, '2022-09-04 14:00:00', 1, 3, 1),
	(34, '2022-09-05 14:00:00', 1, 1, 1),
	(35, '2022-10-02 14:00:00', 1, 1, 3),
	(39, '2022-10-14 15:00:00', 1, 1, 4),
	(36, '2022-10-03 14:00:00', 1, 3, 4),
	(45, '2022-10-19 20:00:00', 1, 4, 1),
	(47, '2022-10-21 20:00:00', 1, 1, 3),
	(50, '2022-10-22 18:00:00', 1, 1, 4),
	(51, '2022-10-23 17:00:00', 1, 3, 3),
	(53, '2022-09-22 20:00:00', 1, 1, 3),
	(54, '2022-09-23 16:00:00', 1, 3, 4),
	(55, '2022-09-24 20:00:00', 1, 1, 3),
	(57, '2022-09-25 17:00:00', 1, 3, 4);
/*!40000 ALTER TABLE "lesson" ENABLE KEYS */;

-- Dumping data for table public.lesson_taken: -1 rows
/*!40000 ALTER TABLE "lesson_taken" DISABLE KEYS */;
/*!40000 ALTER TABLE "lesson_taken" ENABLE KEYS */;

-- Dumping data for table public.lesson_taught: -1 rows
/*!40000 ALTER TABLE "lesson_taught" DISABLE KEYS */;
/*!40000 ALTER TABLE "lesson_taught" ENABLE KEYS */;

-- Dumping data for table public.monthly_fee: -1 rows
/*!40000 ALTER TABLE "monthly_fee" DISABLE KEYS */;
/*!40000 ALTER TABLE "monthly_fee" ENABLE KEYS */;

-- Dumping data for table public.parent: -1 rows
/*!40000 ALTER TABLE "parent" DISABLE KEYS */;
INSERT INTO "parent" ("parent_id", "person_id") VALUES
	(1, 1);
/*!40000 ALTER TABLE "parent" ENABLE KEYS */;

-- Dumping data for table public.person: -1 rows
/*!40000 ALTER TABLE "person" DISABLE KEYS */;
INSERT INTO "person" ("person_id", "ssn", "first_name", "last_name", "city", "street", "zip", "phone_number", "email_address") VALUES
	(9, '197208132481', 'Adam', 'Rosenberg', 'Trelleborg', 'Hallasvängen 8B', '23165', '0706661778', 'adam.rosen@gmail.com'),
	(10, '198001248478', 'Jacob', 'Levin', 'Trelleborg', 'Lycko Pers Väg 13C', '23164', '0702419472', 'jacke.levin@hotmail.com'),
	(11, '200301039467', 'Jonathan', 'Cohen', 'Trelleborg', 'Hallabacken 2A', '23165', '0704448112', 'jonteboy@gmail.com'),
	(5, '201601041265', 'Sara', 'Klein', 'Vellinge', 'Sven Olofsgatan 10B', '23135', NULL, NULL),
	(2, '201208231482', 'Abraham', 'Klein', 'Vellinge', 'Sven Olofsgatan 10B', '23135', '0702514562', 'abbemannen@hotmail.com'),
	(13, '200201027766', 'Daniel', 'Grossman', 'Malmö', 'Birger Jarlsgatan 5C', '21611', '0708498479', 'danneDenStore@hotmail.com'),
	(1, '198803034282', 'Eva', 'Klein', 'Vellinge', 'Sven Olofsgatan 10B', '23135', '0704442445', 'eva.klein@gmail.com'),
	(6, '196012021498', 'Josef', 'Einstein', 'Trelleborg', 'Per Hans Väg 4D', '23165', '0701238429', 'einstein@live.se');
/*!40000 ALTER TABLE "person" ENABLE KEYS */;

-- Dumping data for table public.price_for_a_lesson: -1 rows
/*!40000 ALTER TABLE "price_for_a_lesson" DISABLE KEYS */;
/*!40000 ALTER TABLE "price_for_a_lesson" ENABLE KEYS */;

-- Dumping data for table public.rental_instrument: -1 rows
/*!40000 ALTER TABLE "rental_instrument" DISABLE KEYS */;
INSERT INTO "rental_instrument" ("rental_instrument_id", "instrument_id", "monthly_cost", "brand", "description", "start_of_lease", "student_id") VALUES
	(1, 1, 119, 'Yamaha', NULL, NULL, NULL),
	(3, 2, 249, 'Bechstein', NULL, NULL, NULL),
	(4, 3, 219, 'Yamaha', NULL, NULL, NULL),
	(6, 5, 109, 'Knilling', NULL, NULL, NULL),
	(7, 6, 129, 'Yamaha', NULL, NULL, NULL),
	(11, 4, 119, 'Jupiter', 'soprano saxophone', '2022-01-02 12:00:00', 4),
	(9, 4, 139, 'Selmer', 'alto saxophone', '2022-01-08 12:00:00', 2),
	(13, 4, 109, 'Yamaha', 'baritone saxophone', NULL, NULL),
	(5, 4, 109, 'Yamaha', 'tenor saxophone', NULL, NULL),
	(12, 7, 109, 'Jupiter', 'Contra-alto Clarinet', '2022-01-03 12:00:00', 3),
	(10, 7, 89, 'Selmer', 'Contrabass Clarinet', '2022-01-04 12:00:00', 1),
	(8, 7, 99, 'Yamaha', 'Contrabass Clarinet', '2022-01-05 12:00:00', 1),
	(15, 4, 119, 'Yamaha', 'tenor saxophone', NULL, NULL),
	(14, 7, 99, 'Jupiter', 'Contra-alto Clarinet', NULL, NULL);
/*!40000 ALTER TABLE "rental_instrument" ENABLE KEYS */;

-- Dumping data for table public.rented_instrument_archive: -1 rows
/*!40000 ALTER TABLE "rented_instrument_archive" DISABLE KEYS */;
INSERT INTO "rented_instrument_archive" ("archive_id", "rental_instrument_id", "monthly_cost", "brand", "description", "start_of_lease", "end_of_lease", "student_id") VALUES
	(6, 14, 99, 'Jupiter', 'Contra-alto Clarinet', '2022-01-09 00:00:00', '2022-01-05 00:00:00', 1);
/*!40000 ALTER TABLE "rented_instrument_archive" ENABLE KEYS */;

-- Dumping data for table public.salary_payment: -1 rows
/*!40000 ALTER TABLE "salary_payment" DISABLE KEYS */;
/*!40000 ALTER TABLE "salary_payment" ENABLE KEYS */;

-- Dumping data for table public.sibling: -1 rows
/*!40000 ALTER TABLE "sibling" DISABLE KEYS */;
INSERT INTO "sibling" ("sibling_id", "student_id") VALUES
	(1, 2),
	(2, 1);
/*!40000 ALTER TABLE "sibling" ENABLE KEYS */;

-- Dumping data for table public.student: -1 rows
/*!40000 ALTER TABLE "student" DISABLE KEYS */;
INSERT INTO "student" ("student_id", "person_id", "eligible_for_sibling_discount", "parent_id") VALUES
	(2, 5, 'true', 1),
	(1, 2, 'true', 1),
	(3, 11, 'false', NULL),
	(4, 13, 'false', NULL);
/*!40000 ALTER TABLE "student" ENABLE KEYS */;

-- Dumping data for table public.student_enrolled: -1 rows
/*!40000 ALTER TABLE "student_enrolled" DISABLE KEYS */;
INSERT INTO "student_enrolled" ("student_enrolled_id", "instrument_id", "student_id", "group_lesson_id") VALUES
	(5, 7, 1, 11),
	(6, 4, 2, 11),
	(8, 7, 1, 9),
	(9, 4, 2, 9),
	(1, 4, 2, 25),
	(3, 7, 1, 25),
	(11, 7, 1, 28),
	(12, 4, 2, 28),
	(14, 7, 3, 28),
	(15, 4, 4, 28);
/*!40000 ALTER TABLE "student_enrolled" ENABLE KEYS */;

-- Dumping data for table public.venue: -1 rows
/*!40000 ALTER TABLE "venue" DISABLE KEYS */;
INSERT INTO "venue" ("venue_id", "venue_name", "suitable_for_group_lessons") VALUES
	(1, 'Room 10', 'true'),
	(3, 'Room 11', 'true'),
	(4, 'Room 12', 'false');
/*!40000 ALTER TABLE "venue" ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
