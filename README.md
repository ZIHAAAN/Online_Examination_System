# Project Summary

## Project description
Nowadays, people face an increasing number of exams, such as mid-term exams, final exams, or driver's license exams. Traditional exam formats are time-consuming and labor-intensive, especially after the exams when teachers or administrators need to spend a lot of time grading the papers. Additionally, there may be errors in grading due to oversight. Therefore, I came up with the idea of creating an online exam system with automatic grading functionality.
My project is a web application called the Universal Examination System, which features automatic grading. Teachers or exam administrators can publish exams online, and students or test-takers can answer questions online on the website. After completing the answers, the system can automatically grade and generate an exam report based on the results.
## User steps
Registration and Login
Users need to register as a student or an administrator account based on their needs and log into the system before use.
### Administrator Account
#### Manage Students
After logging in, teachers can go to the My Students page to browse their assigned students. By clicking the Add Student button, they can search for students by ID or name and add them to their student list.
#### Upload Questions
On the Question Management page, teachers can browse all the uploaded questions. By clicking the Add Questions button, they can set the question content, type, options, and answers in the pop-up modal. After clicking the confirm button, the question will be uploaded successfully.
Schedule Exam
Once the above steps are completed, teachers can arrange the first exam for students. By going to the Examination Arrangement page and clicking the New Examination button, they can set the start and end times of the exam in the pop-up modal. Clicking the Search button will display all students and all uploaded questions, with the option to quickly locate students by ID or name. After setting the exam options, clicking the Confirm button will publish the exam.
#### Mark Exam
After students submit their exams, teachers or administrators can go to the Marking page to see all the exams that need to be graded. By clicking the Auto Mark button, they can grade all the submitted exams with one click.
#### View Grade and Report
On the Grade Report page, teachers can see the average scores and submission numbers for all published exams. By clicking the View button under Operation for a specific exam, they can view a pie chart of the score distribution and each student's score (accuracy rate).
### Student Account
#### View Exam
After logging in, student accounts are automatically redirected to the My Examination page, where they can view the list of exam arrangements. When an exam is available, they can start it by clicking the Start button.
#### Take Exam
On this page, students will answer questions with both the questions and options displayed in a random order. They can check the remaining time in the countdown floating window. After completing the exam, they can submit it by clicking the Submit button.
#### View Grade
On the My Grade page, students can view all submitted exams. Graded exam scores will be displayed, while ungraded submissions will show as "Not marked."
## Technologies used & Architecture
Frontend Technologies
The frontend uses HTML, CSS, and JavaScript to build the user interface. HTML provides the structure of the pages, CSS is responsible for the styling, and JavaScript enables dynamic interactions such as form validation and data submission.
Backend Technologies
The backend is built with the ASP.NET framework, handling server-side logic and managing data storage with a MySQL database. ASP.NET processes requests from the frontend, executes business logic, and interacts with the database.
Frontend-Backend Interaction
The frontend sends user data (e.g., exam answers, login information) to the backend via HTTP requests in JSON format. The backend processes these requests and returns the results to the frontend in JSON format. 
## Future works
### Function expansion
#### Public question bank
Before releasing exams in the current project, it is necessary to upload questions. For some daily subjects, many questions are repeatedly uploaded by different teachers, which not only causes inconvenience for the teachers but also leads to significant data redundancy in the database. Therefore, future versions should introduce the design of a public question bank. Different subject questions should be stored in the public question bank according to categories. For example, for Discrete Mathematics, a math teacher only needs to select the Discrete Mathematics group in the public question bank and can then search for the required questions to arrange the exam without having to manually upload each question individually. 
#### Keyword mark
In the current version, for objective questions, the student's answer must exactly match the teacher's preset answer to be marked as correct. This may not be suitable for some questions. Therefore, in future versions, I will improve this functionality to allow for preset keywords as answers. When the student's answer contains the teacher's given keywords, it will be marked as correct by the system.
#### Code mark
In future versions, the exam system should be able to simulate running common code such as C or Java and grade the student's code based on the results of its execution.
#### Personal grade report
Generate a performance analysis for each student, rather than only being able to analyze the performance of all students who submitted the exam. Based on individual answers, the system should calculate the accuracy rate for each type of question and generate a personalized performance report. This report should highlight the student's strengths and weaknesses, providing valuable insights for guiding their future studies.
### Technology upgrade
#### File MD5 or SHA-256 check
The uploaded questions or image files may be identical, wasting server storage space. Therefore, MD5 or SHA-256 file analysis functionality will be added. For files that already exist on the server, the system will directly use the existing files instead of uploading them again.
#### High-concurrency
Test and enhance the system's high concurrency handling capabilities to ensure stability when a large number of users access the system simultaneously.

