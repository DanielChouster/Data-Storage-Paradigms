CREATE TABLE instrument (
 instrument_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 name_of_instrument VARCHAR(500) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE person (
 person_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 SSN VARCHAR(12) UNIQUE NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 city VARCHAR(500),
 street VARCHAR(500),
 zip VARCHAR(500),
 phone_number VARCHAR(500),
 email_address VARCHAR(500)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE price_for_a_lesson (
 price_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 skill_level INT NOT NULL,
 hourly_price DECIMAL(500) NOT NULL,
 instrument_id INT NOT NULL,
 lesson_type VARCHAR(500) NOT NULL
);

ALTER TABLE price_for_a_lesson ADD CONSTRAINT PK_price_for_a_lesson PRIMARY KEY (price_id);


CREATE TABLE venue (
 venue_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 venue_name VARCHAR(500) NOT NULL,
 suitable_for_group_lessons BOOLEAN NOT NULL
);

ALTER TABLE venue ADD CONSTRAINT PK_venue PRIMARY KEY (venue_id);


CREATE TABLE instructor (
 instructor_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 hourly_salary DECIMAL(500) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instrument_taught (
 instrument_id INT NOT NULL,
 instructor_id INT NOT NULL
);


CREATE TABLE lesson (
 lesson_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 start_time TIMESTAMP(6) NOT NULL,
 number_of_hours INT NOT NULL,
 venue_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE parent (
 parent_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 person_id INT NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (parent_id);


CREATE TABLE salary_payment (
 salary_payment_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 total_salary_for_this_payment DECIMAL(500) NOT NULL,
 date_of_payment DATE NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE salary_payment ADD CONSTRAINT PK_salary_payment PRIMARY KEY (salary_payment_id);


CREATE TABLE student (
 student_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 person_id INT NOT NULL,
 eligible_for_sibling_discount BOOLEAN NOT NULL,
 parent_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE application (
 application_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 skill_level INT NOT NULL,
 person_id INT NOT NULL,
 parent_id INT,
 instrument_id INT NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (application_id);


CREATE TABLE group_lesson (
 group_lesson_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 lesson_id INT NOT NULL,
 min_num_of_students_requirement INT NOT NULL,
 max_num_of_students_limit INT NOT NULL,
 skill_level INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE individual_lesson (
 individual_lesson_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 lesson_id INT NOT NULL,
 student_id INT,
 instrument_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id);


CREATE TABLE instrument_learning (
 skill_level INT NOT NULL,
 instrument_id INT NOT NULL,
 student_id INT NOT NULL
);


CREATE TABLE lesson_taught (
 instructor_id INT NOT NULL,
 salary_payment_id INT NOT NULL,
 lesson_type VARCHAR(500) NOT NULL,
 number_of_hours DECIMAL(500) NOT NULL
);

ALTER TABLE lesson_taught ADD CONSTRAINT PK_lesson_taught PRIMARY KEY (instructor_id);


CREATE TABLE monthly_fee (
 monthly_fee_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 total_fee DECIMAL(500) NOT NULL,
 discount DECIMAL(500),
 date_of_payment DATE NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE monthly_fee ADD CONSTRAINT PK_monthly_fee PRIMARY KEY (monthly_fee_id);


CREATE TABLE rental_instrument (
 rental_instrument_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 instrument_id INT NOT NULL,
 monthly_cost DECIMAL(500) NOT NULL,
 brand VARCHAR(500),
 description VARCHAR(500),
 start_of_lease TIMESTAMP(6),
 student_id INT
);

ALTER TABLE rental_instrument ADD CONSTRAINT PK_rental_instrument PRIMARY KEY (rental_instrument_id);


CREATE TABLE rented_instrument_archive (
 archive_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 rental_instrument_id INT NOT NULL,
 monthly_cost DECIMAL(500) NOT NULL,
 brand VARCHAR(500),
 description VARCHAR(500),
 start_of_lease TIMESTAMP(6) NOT NULL,
 end_of_lease TIMESTAMP(6) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE rented_instrument_archive ADD CONSTRAINT PK_rented_instrument_archive PRIMARY KEY (archive_id);



CREATE TABLE sibling (
 sibling_id INT NOT NULL,
 student_id INT NOT NULL
);


CREATE TABLE student_enrolled (
 student_enrolled_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 instrument_id INT NOT NULL,
 student_id INT,
 group_lesson_id INT
);

ALTER TABLE student_enrolled ADD CONSTRAINT PK_student_enrolled PRIMARY KEY (student_enrolled_id);


CREATE TABLE booking (
 booking_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 date TIMESTAMP(6) NOT NULL,
 instructor_id INT NOT NULL,
 individual_lesson_id INT
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);


CREATE TABLE ensemble (
 group_lesson_id INT NOT NULL,
 target_genre VARCHAR(500) NOT NULL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (group_lesson_id);


CREATE TABLE lesson_taken (
 lesson_taken_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
 monthly_fee_id INT NOT NULL,
 number_of_hours INT NOT NULL,
 price_id INT NOT NULL
);

ALTER TABLE lesson_taken ADD CONSTRAINT PK_lesson_taken PRIMARY KEY (lesson_taken_id);


ALTER TABLE price_for_a_lesson ADD CONSTRAINT FK_price_for_a_lesson_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instrument_taught ADD CONSTRAINT FK_instrument_taught_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE instrument_taught ADD CONSTRAINT FK_instrument_taught_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (venue_id) REFERENCES venue (venue_id);
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE parent ADD CONSTRAINT FK_parent_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE salary_payment ADD CONSTRAINT FK_salary_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE student ADD CONSTRAINT FK_student_1 FOREIGN KEY (parent_id) REFERENCES parent (parent_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (parent_id) REFERENCES parent (parent_id);
ALTER TABLE application ADD CONSTRAINT FK_application_2 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE instrument_learning ADD CONSTRAINT FK_instrument_learning_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE instrument_learning ADD CONSTRAINT FK_instrument_learning_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE lesson_taught ADD CONSTRAINT FK_lesson_taught_0 FOREIGN KEY (salary_payment_id) REFERENCES salary_payment (salary_payment_id);


ALTER TABLE monthly_fee ADD CONSTRAINT FK_monthly_fee_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE rental_instrument ADD CONSTRAINT FK_rental_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE rental_instrument ADD CONSTRAINT FK_rental_instrument_1 FOREIGN KEY (student_id) REFERENCES student (student_id);

ALTER TABLE rented_instrument_archive ADD CONSTRAINT FK_rented_instrument_archive_0 FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument (rental_instrument_id);
ALTER TABLE rented_instrument_archive ADD CONSTRAINT FK_rented_instrument_archive_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_enrolled ADD CONSTRAINT FK_student_enrolled_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE student_enrolled ADD CONSTRAINT FK_student_enrolled_1 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_enrolled ADD CONSTRAINT FK_student_enrolled_2 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (individual_lesson_id) REFERENCES individual_lesson (individual_lesson_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);


ALTER TABLE lesson_taken ADD CONSTRAINT FK_lesson_taken_0 FOREIGN KEY (monthly_fee_id) REFERENCES monthly_fee (monthly_fee_id);
ALTER TABLE lesson_taken ADD CONSTRAINT FK_lesson_taken_1 FOREIGN KEY (price_id) REFERENCES price_for_a_lesson (price_id);
