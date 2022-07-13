SELECT student.student_id,
    student.person_id,
    student.eligible_for_sibling_discount,
    student.parent_id,
    person.ssn,
    person.first_name,
    person.last_name,
    person.city,
    person.street,
    person.zip,
    person.phone_number,
    person.email_address
   FROM student
     JOIN person ON person.person_id = student.person_id;
