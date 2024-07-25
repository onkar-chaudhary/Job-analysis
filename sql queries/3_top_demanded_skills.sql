--Identifying the most demanded skills for my prefrences

SELECT
    skills.skills,
    COUNT(jobs.job_id) AS demand_count
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
    demand_count DESC
LIMIT 10;