-- List all ensembles held during the next week, sorted by music genre and weekday. 
-- For each ensemble tell whether it's full booked, has 1-2 seats left or has more seats left.


SELECT week_number,week_day,start_time,first_name,last_name,venue_name,number_of_hours,min_num_of_students_requirement,max_num_of_students_limit,q.BOOKED,skill_level,target_genre,
CASE
WHEN q.BOOKED>=max_num_of_students_limit  THEN 'Full booked'
WHEN  max_num_of_students_limit-q.BOOKED>2 THEN 'More seats left'
ELSE '1-2 seats left'
END AS AVAILABILITY
FROM (
SELECT *,date_part('week',start_time) AS WEEK_NUMBER,To_Char("start_time", 'Day') AS WEEK_day,
(SELECT COUNT(student_enrolled_id) FROM student_enrolled WHERE group_lesson_id=lesson_view.group_lesson_id) AS BOOKED
from lesson_view 
FULL OUTER JOIN instructor_view
 ON instructor_view.instructor_id=lesson_view.instructor_id
WHERE EXTRACT(YEAR FROM start_time)=EXTRACT(YEAR FROM now()) AND TYPE='Ensemble'
AND date_part('week',start_time)=date_part('week',NOW())+1
ORDER BY target_genre,date_part('dow',start_time)) q
