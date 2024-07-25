--Identifying the top paying skills

SELECT
    skills.skills,
    ROUND(AVG(salary_year_avg), 3) AS avg_salary
FROM
    job_postings_fact AS jobs
INNER JOIN
    skills_job_dim AS skills_to_jobs
    ON jobs.job_id = skills_to_jobs.job_id
INNER JOIN
    skills_dim AS skills
    ON skills_to_jobs.skill_id = skills.skill_id
WHERE
    (jobs.job_title_short IN('Data Analyst', 'Software Engineer', 'Business Analyst')) AND
    (jobs.job_location IN('New York, NY', 'Bengaluru, Karnataka, India', 'Singapore', 'United Knigdom', 'Anywhere')) AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
ORDER BY
    avg_salary DESC
LIMIT 10;