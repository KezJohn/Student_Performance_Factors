SELECT * 
FROM student_performance_factor.student_performance_factor
;

# Hours studied, Attendence, Extracurricular activities, sleep hours, parental environment, influence, teacher quality , exam score, peer influence 
# Removing Null values

SELECT *
FROM student_performance_factor.student_performance_factor
WHERE Teacher_Quality IS NULL OR Teacher_Quality = '';

DELETE FROM student_performance_factor.student_performance_factor
WHERE Teacher_Quality IS NULL OR Teacher_Quality = '';



# Students who slept less than 6 hrs could only make grades upto  C 

SELECT Hours_Studied, AVG(Sleep_Hours) AS avg_sleep_hours, AVG(Exam_Score) AS avg_exam_score
FROM student_performance_factor.student_performance_factor
WHERE Sleep_Hours < 6
GROUP BY Hours_Studied
ORDER BY 3 ASC;


SELECT Exam_Score, School_Type, Teacher_Quality
FROM student_performance_factor.student_performance_factor
GROUP BY Exam_Score, School_Type, Teacher_Quality
ORDER BY 1 DESC;

SELECT 
    CASE 
        WHEN Teacher_Quality = 'High' THEN 'High'
        WHEN Teacher_Quality = 'Medium' THEN 'Medium'
        WHEN Teacher_Quality = 'Low' THEN 'Low'
        ELSE 'Unknown'  -- Optional: Handle cases that don't match the criteria
    END AS Teacher_Quality_Category,
    AVG(Exam_Score) AS average_exam_score
FROM 
    student_performance_factor.student_performance_factor
GROUP BY 
    Teacher_Quality_Category
ORDER BY 
    FIELD(Teacher_Quality_Category, 'High', 'Medium', 'Low');  -- Orders by predefined categories
    
   SELECT 
    CASE 
        WHEN School_Type = 'Public' THEN 'Public'
        WHEN School_Type = 'Private' THEN 'Private'
        ELSE 'Unknown'  
    END AS School_Type,
    AVG(Exam_Score) AS Average_Exam_Score  -- Aggregate function for Exam_Score
FROM 
    student_performance_factor.student_performance_factor
GROUP BY 
    School_Type  
ORDER BY 
    FIELD(School_Type, 'Public', 'Private', 'Unknown'); 
    

SELECT 
    Physical_Activity,
    AVG(Exam_Score) AS Average_Score
FROM 
    student_performance_factor.student_performance_factor
GROUP BY 
    Physical_Activity
Order by 2
;

ALTER TABLE student_performance_factor.student_performance_factor
ADD COLUMN Physical_Activity_Category VARCHAR(20);

UPDATE student_performance_factor.student_performance_factor
SET Physical_Activity_Category = 
    CASE 
         WHEN Physical_Activity IN (0) THEN 'High'
        WHEN Physical_Activity IN (1, 2) THEN 'Medium'
        WHEN Physical_Activity IN (3, 4) THEN 'Low'
        WHEN Physical_Activity IN (5, 6) THEN 'None'
        ELSE 'Unknown'
    END;



SELECT 
    Physical_Activity_Category,
    AVG(Sleep_Hours) AS Average_Sleep_Hours,
    AVG(Attendance) AS Average_Attendance,
    AVG(Exam_Score) AS Average_Score
FROM 
    student_performance_factor.student_performance_factor
GROUP BY 
    Physical_Activity_Category
ORDER BY 
    FIELD(Physical_Activity_Category, 'Low', 'Medium', 'High');  -- Orders by predefined categories

    
    
    


