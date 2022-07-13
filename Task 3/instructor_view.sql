SELECT instructor.instructor_id,
    instructor.hourly_salary,
    person.person_id,
    person.ssn,
    person.first_name,
    person.last_name,
    person.city,
    person.street,
    person.zip,
    person.phone_number,
    person.email_address
   FROM instructor
     JOIN person ON person.person_id = instructor.person_id;
