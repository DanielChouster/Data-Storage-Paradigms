SELECT lesson.lesson_id,
    lesson.start_time,
    date_part('week'::text, lesson.start_time) AS week,
    lesson.number_of_hours,
    lesson.venue_id,
    lesson.instructor_id,
    group_lesson.group_lesson_id,
    group_lesson.min_num_of_students_requirement,
    group_lesson.max_num_of_students_limit,
    group_lesson.skill_level,
    ensemble.target_genre,
    venue.venue_name,
    EXTRACT(month FROM lesson.start_time) AS month,
        CASE
            WHEN individual_lesson.individual_lesson_id IS NOT NULL THEN 'Individual'::text
            WHEN ensemble.target_genre IS NOT NULL THEN 'Ensemble'::text
            ELSE 'Group'::text
        END AS type
   FROM lesson
     FULL JOIN individual_lesson ON individual_lesson.lesson_id = lesson.lesson_id
     FULL JOIN group_lesson ON group_lesson.lesson_id = lesson.lesson_id
     FULL JOIN ensemble ON ensemble.group_lesson_id = group_lesson.group_lesson_id
     FULL JOIN venue ON venue.venue_id = lesson.venue_id;
