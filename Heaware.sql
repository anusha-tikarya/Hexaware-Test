# Hexaware-Test
--Task 1:
create database CareerHub
use CareerHub 

--Task 2:
Create Table Companies (
 company_id Int Primary Key ,
 Company_Name Varchar(250),
 Location Varchar (250));

CREATE TABLE Jobs (Job_id INT PRIMARY KEY,Company_id INT, Job_Title VARCHAR(200),
 Job_Description text,Job_Location VARCHAR(250),
 Salary DECIMAL(10, 2), Job_Type VARCHAR(250), Posted_Date DATETIME);

Create table Applicants(
Applicant_id INT PRIMARY KEY,
First_Name Varchar (250),
Last_Name Varchar(250),
Email Varchar(250),
Phone Varchar (200),
Resume Text );

create table applications(
application_id int primary key,
job_id int,
applicant_id int,
application_date date,
cover_letter text
);

ALTER TABLE Jobs
ADD CONSTRAINT FK_Company_id
FOREIGN KEY (Company_id)
REFERENCES Companies(company_id)

ALTER TABLE applications
ADD CONSTRAINT FK_job_id
FOREIGN KEY (job_id)
REFERENCES jobs(job_id)


ALTER TABLE Applications
ADD CONSTRAINT FK_Applicant_id
FOREIGN KEY (applicant_id)
REFERENCES Applicants(Applicant_id);

--- TAsk 3:
INSERT INTO Companies (company_id, Company_Name,Location) VALUES
(1,'Tech Innovations', 'San Francisco'),
(2,'Data Driven Inc', 'New York'),
(3,'GreenTech Solutions', 'Austin'),
(4,'CodeCrafters', 'Boston'),
(5,'HexaWare Technologies', 'Chennai');


INSERT INTO Jobs (job_id,Company_id, Job_Title, Job_Description, Job_Location, Salary, Job_Type, Posted_Date) VALUES
(1,1, 'Frontend Developer', 'Develop user-facing features', 'San Francisco', 75000, 'Full-time', '2023-01-10'),
(2,2, 'Data Analyst', 'Interpret data models', 'New York', 68000, 'Full-time', '2023-02-20'),
(3,3, 'Environmental Engineer', 'Develop environmental solutions', 'Austin', 85000, 'Full-time', '2023-03-15'),
(4,1, 'Backend Developer', 'Handle server-side logic', 'Remote', 77000, 'Full-time', '2023-04-05'),
(5,4, 'Software Engineer', 'Develop and test software systems', 'Boston', 90000, 'Full-time', '2023-01-18'),
(6,5, 'HR Coordinator', 'Manage hiring processes', 'Chennai', 45000, 'Contract', '2023-04-25'),
(7,2, 'Senior Data Analyst', 'Lead data strategies', 'New York', 95000, 'Full-time', '2023-01-22');


INSERT INTO Applicants (Applicant_id, First_Name,Last_Name, Email, Phone, Resume) VALUES
(1,'John', 'Doe', 'john.doe@example.com', '123-456-7890', 'Experienced web developer with 5 years of experience.'),
(2,'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'Data enthusiast with 3 years of experience in data analysis.'),
(3,'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', 'Environmental engineer with 4 years of field experience.'),
(4,'Bob', 'Brown', 'bob.brown@example.com', '456-789-0123', 'Seasoned software engineer with 8 years of experience.');


INSERT INTO Applications (application_id,job_id, applicant_id, application_date, cover_letter) VALUES
(1,1, 1, '2023-04-01', 'I am excited to apply for the Frontend Developer position.'),
(2,2, 2, '2023-04-02', 'I am interested in the Data Analyst position.'),
(3,3, 3, '2023-04-03', 'I am eager to bring my expertise to your team as an Environmental Engineer.'),
(4,4, 4, '2023-04-04', 'I am applying for the Backend Developer role to leverage my skills.'),
(5,5, 1, '2023-04-05', 'I am also interested in the Software Engineer position at CodeCrafters.');
---- Task 4 : No Error
---Task5:
SELECT Jobs.Job_id, COUNT(Applications.application_id) AS Application_Count
FROM Jobs
LEFT JOIN Applications ON Jobs.Job_id = Applications.job_id
GROUP BY Jobs.Job_id;

--- Task 6:
Select J.Job_Title, C.Company_Name, J.Job_Location, J.Salary From Jobs J
join Companies C ON J.Company_id = C.company_id
where J.Salary BETWEEN 10000 AND 50000;

---Task 7:
Select Jobs.Job_Title, Companies.Company_Name, Applications.application_date
From Applications INNER JOIN Jobs ON Applications.job_id = Jobs.Job_id
Inner Join  Companies ON Jobs.Company_id = Companies.company_id
Where Applications.applicant_id = 2;

---Task 8:
Select company_id ,avg(salary) AS average_salary 
From Jobs
Where salary>0
Group by Company_id;

---Task 9:
SELECT TOP 1 C.Company_Name, COUNT(J.Job_ID) AS 'Job Count'
FROM Companies C
LEFT JOIN Jobs J ON C.company_id = J.Company_id
GROUP BY C.Company_Name
ORDER BY COUNT(J.Job_id) DESC;

---TASK 10:
select a.applicant_id
FROM Applicants a
INNER JOIN applications j ON a.Applicant_id =j.applicant_id
INNER JOIN Jobs c ON j.job_id = c.Job_id
where c.Job_Location='new york'

---Task 11:
Select Distinct Job_Title, Salary From Jobs
Where Salary BETWEEN 60000 AND 80000;

--- Task 12: 
Select Job_id, Job_Title
From Jobs
Where Job_id NOT IN (Select Distinct Job_id FROM Applications)

--Task 13
SELECT A.First_Name, A.Last_Name, C.Company_Name, J.Job_Title
FROM Applicants A
INNER JOIN Applications Ap ON A.Applicant_id = Ap.applicant_id
INNER JOIN Jobs J ON Ap.job_id = J.Job_id
INNER JOIN Companies C ON J.Company_id = C.company_id;

---Task 14
SELECT C.Company_Name, ISNULL(COUNT(J.Job_id), 0) AS 'Job Count'
FROM Companies C
LEFT JOIN Jobs J ON C.Company_ID = J.Company_id
GROUP BY C.Company_Name;

---Task 15
SELECT A.First_Name, A.Last_Name, ISNULL(C.Company_Name, 'Not Applied') AS 'Company Name', ISNULL(J.Job_Title, 'Not Applied') AS 'Job Title'
FROM Applicants A
LEFT JOIN Applications Ap ON A.Applicant_ID = Ap.applicant_id
LEFT JOIN Jobs J ON Ap.job_id = J.Job_id
LEFT JOIN Companies C ON J.Company_id = C.company_id;

---Task 16
Select Distinct Companies.Company_Name
From Companies
Inner Join Jobs ON Companies.company_id = Jobs.Company_id
Where Jobs.Salary > (SELECT AVG(Salary) FROM Jobs);

---Task 17
ALTER TABLE Applicants
ADD City VARCHAR(100),
    State VARCHAR(100);
UPDATE Applicants
SET City = 'Indore', 
    State = 'Bhopal'; 
SELECT Applicants.First_Name, Applicants.Last_Name, Companies.Company_Name
FROM Applicants
CROSS JOIN Companies
WHERE Companies.Location = 'Chennai'
AND DATEDIFF(DAY, Applicants.Resume, GETDATE()) >= 730;

---Task 18 
Select * from Jobs
Where Job_Title LIKE '%Developer%' OR Job_Title LIKE '%Engineer%';

---Task 19 
Select Applicants.First_Name, Applicants.Last_Name, Companies.Company_Name, Jobs.Job_Title
From Applicants
CROSS JOIN Companies
CROSS JOIN Jobs
LEFT JOIN Applications ON Applicants.Applicant_id = Applications.applicant_id AND Jobs.Job_id = Applications.job_id;

---Task 20 
SELECT Applicants.First_Name, Applicants.Last_Name, Companies.Company_Name
FROM Applicants
CROSS JOIN Companies
WHERE Companies.Location = 'Chennai'
