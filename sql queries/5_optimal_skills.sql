-- Identifying the optimal skills to learn

WITH skills_demand AS (
    SELECT
        skills.skill_id,
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
        skills.skill_id
), average_salary AS (
    SELECT
        skills_to_jobs.skill_id,
        ROUND(AVG(jobs.salary_year_avg), 3) AS avg_salary
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
        skills_to_jobs.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary
    ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
    avg_salary DESC, demand_count DESC;