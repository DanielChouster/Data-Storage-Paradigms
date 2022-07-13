-- Show the number of lessons given per month during a specified year. 
-- It shall be possible to retrieve the total number of lessons per month (just one number per month) and the specific number of individual lessons, 
-- group lessons and ensembles (three numbers per month). 
-- This query is expected to be performed a few times per week.

-- This query is for the year 2022. To change year, replace "2022" with another value.

SELECT q.MONTH,q.ALL_LESSONS,q1.INDIVIDUAL_LESSONS,q2.ENSEMBLE_LESSONS,q3.GROUP_LESSONS FROM (
SELECT COUNT(lesson_id) AS ALL_LESSONS,MONTH FROM lesson_view WHERE EXTRACT(YEAR FROM start_time)=2022 GROUP BY MONTH) q

FULL OUTER JOIN (
SELECT COUNT(lesson_id) AS INDIVIDUAL_LESSONS ,MONTH FROM lesson_view 
WHERE EXTRACT(YEAR FROM start_time)=2022 AND TYPE='Individual' GROUP BY MONTH
) q1 ON q1.MONTH=q.MONTH

FULL OUTER JOIN (
SELECT COUNT(lesson_id) AS ENSEMBLE_LESSONS, MONTH FROM lesson_view 
WHERE EXTRACT(YEAR FROM start_time)=2022 AND TYPE='Ensemble' GROUP BY MONTH
) q2 ON q2.MONTH=q.MONTH

FULL OUTER JOIN (
SELECT COUNT(lesson_id) AS GROUP_LESSONS,MONTH FROM lesson_view 
WHERE EXTRACT(YEAR FROM start_time)=2022 AND TYPE='Group' GROUP BY MONTH
) q3 ON q3.MONTH=q.MONTH
