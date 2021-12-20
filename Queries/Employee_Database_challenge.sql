-- Challenge
-- Number of [titles] retiring
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO ret_titles
FROM current_emp AS ce
	INNER JOIN titles AS ti
		ON (ce.emp_no = ti.emp_no)
ORDER BY ce.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM ret_titles AS rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;


-- Mentorship Eligibility table
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
INTO mentorship_eligibilty
FROM employees AS e
	LEFT OUTER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	Left OUTER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;