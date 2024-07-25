--Identifying the skills required for some top paying jobs

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        companies.name
    FROM
        job_postings_fact AS jobs
    LEFT JOIN
        company_dim AS companies
        ON jobs.company_id = companies.company_id
    WHERE
        (job_title_short IN('Data Analyst', 'Software Engineer', 'Business Analyst')) AND
        (job_location IN('New York, NY', 'Bengaluru, Karnataka, India', 'Singapore', 'United Knigdom', 'Anywhere')) AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 50
)
SELECT
    top_paying_jobs.*,
    skills.skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim AS skills_to_jobs
    ON top_paying_jobs.job_id = skills_to_jobs.job_id
INNER JOIN
    skills_dim AS skills
    ON skills_to_jobs.skill_id = skills.skill_id;