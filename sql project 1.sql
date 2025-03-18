create database library;

create table branch (branch_no int primary key,manager_id int,branch_address varchar(50),contact_no int);
create table employee (emp_id int primary key,emp_name varchar(50),position varchar(50),salary int,branch_no int);
create table books (isbn int primary key,book_title varchar(50),category varchar(50),rental_price int,status varchar(10),author_publisher varchar(50));
create table customer (customer_id int primary key,customer_name varchar(50),customer_address varchar(50),reg_date date);
create table issuestatus (issue_id int primary key,issued_cost int,issued_book_name varchar(50),issue_date date,isbn_book int);
create table returnstatus (return_id int primary key,return_cost int,return_book_name varchar(50),return_date date,isbn_book2 int);

insert into branch (branch_no,manager_id,branch_address,contact_no) values
(1, 1, '123 Main St',1234),
(2, 2, '456 Elm St',  9876),
(3, 3, '789 Oak St', 1122),
(4, 4, '101 Maple St',  5566),
(5, 5, '202 Pine St',  6677);


insert into employee (emp_id, emp_name, position, salary, branch_no) values
(1, 'Alice Johnson', 'Manager', 75000, 1),
(2, 'Bob Smith', 'Sales Associate', 50000, 2),
(3, 'Charlie Brown', 'Accountant', 60000, 3),
(4, 'David White', 'HR Specialist', 55000, 4),
(5, 'Emma Davis', 'Customer Support', 48000, 5);


insert into books (isbn, book_title, category, rental_price, status, author_publisher) values
(1001, 'The Great Gatsby', 'Fiction', 10, 'yes', 'F. Scott Fitzgerald - Scribner'),
(1002, '1984', 'Dystopian', 12, 'no', 'George Orwell - Secker & Warburg'),
(1003, 'To Kill a Mockingbird', 'Classic', 15, 'yes', 'Harper Lee - J.B. Lippincott & Co.'),
(1004, 'The Catcher in the Rye', 'Literary', 10, 'yes', 'J.D. Salinger - Little, Brown and Company'),
(1005, 'Moby-Dick', 'Adventure', 18, 'no', 'Herman Melville - Harper & Brothers');


insert into customer (customer_id, customer_name, customer_address, reg_date) values
(1, 'John Doe', '123 Main St, New York', '2024-01-15'),
(2, 'Alice Smith', '456 Elm St, Los Angeles', '2024-02-10'),
(3, 'Bob Johnson', '789 Oak St, Chicago', '2024-03-05'),
(4, 'Emma Davis', '101 Maple St, Houston', '2024-04-20'),
(5, 'Michael Brown', '202 Pine St, Miami', '2024-05-08');


insert into issuestatus (issue_id, issued_cost, issued_book_name, issue_date, isbn_book) values
(1, 1, 'The Great Gatsby', '2025-03-01', 1001),
(2, 2, '1984', '2025-03-05', 1002),
(3, 3, 'To Kill a Mockingbird', '2025-03-10', 1003),
(4, 4, 'The Catcher in the Rye', '2025-03-12', 1004),
(5, 5, 'Moby-Dick', '2025-03-15', 1005);


insert into returnstatus (return_id, return_cost, return_book_name, return_date, isbn_book2) values
(1, 10, 'The Great Gatsby', '2025-03-10', 1001),
(2, 12, '1984', '2025-03-15', 1002),
(3, 15, 'To Kill a Mockingbird', '2025-03-18', 1003),
(4, 10, 'The Catcher in the Rye', '2025-03-20', 1004),
(5, 18, 'Moby-Dick', '2025-03-25', 1005);

select * from branch;
select * from employee;
select * from books;
select * from customer;
select * from issuestatus;
select * from returnstatus;

#1 Retrieve the book title, category, and rental price of all available books.

select book_title, category, rental_price 
from books 
where status = 'Yes';

#2 List the employee names and their respective salaries in descending order of salary.

select emp_name, salary 
from employee 
order by salary desc;

#3 Retrieve the book titles and the corresponding customers who have issued those books.

select issuestatus.issued_book_name, customer.customer_name 
from issuestatus 
join customer on issuestatus.issue_id = customer.customer_id;

#4 Display the total count of books in each category.

select category, COUNT(*) as total_books 
from books 
group by category;

#5 Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

select emp_name, position 
from employee 
where salary > 50000;

#6 List the customer names who registered before 2022-01-01 and have not issued any books yet.

select customer_name 
from customer 
where reg_date < '2022-01-01' 
and customer_id not in (select issue_id from issuestatus);

#7 Display the branch numbers and the total count of employees in each branch.

select branch_no, COUNT(*) as total_employees 
from employee 
group by branch_no;

#8 Display the names of customers who have issued books in the month of June 2023.

select c.customer_name 
from customer c
join issuestatus i on c.customer_id = i.issue_id
where issue_date between '2023-06-01' and '2023-06-30';

#9 Retrieve book_title from book table containing history.

select book_title 
from books 
where book_title like '%history%';

#10 Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

select branch_no, COUNT(*) as total_employees 
from employee 
group by branch_no 
having COUNT(*) > 5;

#11 Retrieve the names of employees who manage branches and their respective branch addresses.

select e.emp_name, b.branch_address 
from employee e
join branch b on e.emp_id = b.manager_id;


#12 Display the names of customers who have issued books with a rental price higher than Rs. 25.

select distinct c.customer_name 
from customer c
join issuestatus i on c.customer_id = i.issue_id
join books b on i.isbn_book = b.isbn
where b.rental_price > 25;

