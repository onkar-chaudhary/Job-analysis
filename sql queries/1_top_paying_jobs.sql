--Identifying the top paying jobs according to my prefrences

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
LIMIT 50;