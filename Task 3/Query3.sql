-- This query will be used to find instructors risking to work too much, and will be executed daily.
-- List all instructors who has given more than a specific number of lessons during the current month. 
-- Sum all lessons, independent of type, and sort the result by the number of given lessons. 

-- This query shows all instructors who have given more than two lessons. To change this number, replace "2" with another value.

SELECT * FROM(
SELECT ssn,first_name,last_name,SUM(number_of_hours) AS total_number_of_lessons FROM instructor_view 
FULL OUTER JOIN lesson ON lesson.instructor_id=instructor_view.instructor_id
WHERE EXTRACT(YEAR FROM start_time)=EXTRACT(YEAR FROM now()) AND EXTRACT(MONTH FROM start_time)=EXTRACT(MONTH FROM now())
GROUP BY ssn,first_name,last_name) Q
WHERE total_number_of_lessons>2
ORDER BY total_number_of_lessons DESC
