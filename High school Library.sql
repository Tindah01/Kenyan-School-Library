-- Create the database
-- CREATE DATABASE IF NOT EXISTS high_school_library;
-- USE high_school_library;

-- -- Table for storing student information
-- CREATE TABLE students (
--     student_id VARCHAR(10) PRIMARY KEY,
--     admission_number VARCHAR(15) UNIQUE NOT NULL,
--     first_name VARCHAR(50) NOT NULL,
--     middle_name VARCHAR(50),
--     last_name VARCHAR(50) NOT NULL,
--     form_level ENUM('1', '2', '3', '4') NOT NULL,
--     stream VARCHAR(2) NOT NULL,
--     gender ENUM('Male', 'Female') NOT NULL,
--     date_of_birth DATE NOT NULL,
--     email VARCHAR(100),
--     phone VARCHAR(15),
--     address TEXT,
--     registration_date DATE NOT NULL,
--     is_active BOOLEAN DEFAULT TRUE,
--     CONSTRAINT chk_stream CHECK (stream REGEXP '^[A-Z]$')
-- );

-- -- Table for library staff/administrators
-- CREATE TABLE staff (
--     staff_id VARCHAR(10) PRIMARY KEY,
--     national_id VARCHAR(20) UNIQUE NOT NULL,
--     first_name VARCHAR(50) NOT NULL,
--     middle_name VARCHAR(50),
--     last_name VARCHAR(50) NOT NULL,
--     gender ENUM('Male', 'Female') NOT NULL,
--     email VARCHAR(100) NOT NULL UNIQUE,
--     phone VARCHAR(15) NOT NULL,
--     role ENUM('Librarian', 'Assistant', 'Admin') NOT NULL,
--     hire_date DATE NOT NULL,
--     is_active BOOLEAN DEFAULT TRUE
-- );

-- -- Table for book categories
-- CREATE TABLE categories (
--     category_id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(50) NOT NULL UNIQUE,
--     description TEXT
-- );

-- -- Table for book publishers
-- CREATE TABLE publishers (
--     publisher_id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(100) NOT NULL UNIQUE,
--     address TEXT,
--     contact_phone VARCHAR(15),
--     contact_email VARCHAR(100)
-- );

-- -- Table for book authors
-- CREATE TABLE authors (
--     author_id INT AUTO_INCREMENT PRIMARY KEY,
--     first_name VARCHAR(50) NOT NULL,
--     middle_name VARCHAR(50),
--     last_name VARCHAR(50) NOT NULL,
--     nationality VARCHAR(50),
--     biography TEXT
-- );

-- -- Table for books
-- CREATE TABLE books (
--     book_id INT AUTO_INCREMENT PRIMARY KEY,
--     isbn VARCHAR(20) UNIQUE NOT NULL,
--     title VARCHAR(255) NOT NULL,
--     edition VARCHAR(20),
--     category_id INT NOT NULL,
--     publisher_id INT NOT NULL,
--     publication_year INT,
--     pages INT,
--     language VARCHAR(30) DEFAULT 'English',
--     description TEXT,
--     cover_image VARCHAR(255),
--     date_added DATE NOT NULL,
--     added_by VARCHAR(10) NOT NULL,
--     FOREIGN KEY (category_id) REFERENCES categories(category_id),
--     FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
--     FOREIGN KEY (added_by) REFERENCES staff(staff_id)
-- );

-- -- Junction table for book authors (many-to-many relationship)
-- CREATE TABLE book_authors (
--     book_id INT NOT NULL,
--     author_id INT NOT NULL,
--     PRIMARY KEY (book_id, author_id),
--     FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
--     FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
-- );

-- -- Table for book copies
-- CREATE TABLE book_copies (
--     copy_id INT AUTO_INCREMENT PRIMARY KEY,
--     book_id INT NOT NULL,
--     barcode VARCHAR(20) UNIQUE NOT NULL,
--     acquisition_date DATE NOT NULL,
--     acquisition_price DECIMAL(10,2),
--     shelf_location VARCHAR(20) NOT NULL,
--     status ENUM('Available', 'Borrowed', 'Lost', 'Damaged', 'Under Repair') NOT NULL DEFAULT 'Available',
--     notes TEXT,
--     FOREIGN KEY (book_id) REFERENCES books(book_id)
-- );

-- -- Table for borrowing transactions
-- CREATE TABLE borrowings (
--     borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
--     copy_id INT NOT NULL,
--     student_id VARCHAR(10) NOT NULL,
--     borrowed_date DATETIME NOT NULL,
--     due_date DATE NOT NULL,
--     returned_date DATETIME,
--     returned_condition ENUM('Good', 'Damaged', 'Lost'),
--     fine_amount DECIMAL(10,2) DEFAULT 0.00,
--     processed_by VARCHAR(10) NOT NULL,
--     FOREIGN KEY (copy_id) REFERENCES book_copies(copy_id),
--     FOREIGN KEY (student_id) REFERENCES students(student_id),
--     FOREIGN KEY (processed_by) REFERENCES staff(staff_id),
--     CONSTRAINT chk_due_date CHECK (due_date > DATE(borrowed_date))
-- );

-- -- Table for fines and payments
-- CREATE TABLE fines (
--     fine_id INT AUTO_INCREMENT PRIMARY KEY,
--     borrowing_id INT NOT NULL,
--     amount DECIMAL(10,2) NOT NULL,
--     reason ENUM('Late Return', 'Damage', 'Lost Book') NOT NULL,
--     issued_date DATE NOT NULL,
--     paid_date DATE,
--     paid_amount DECIMAL(10,2),
--     processed_by VARCHAR(10),
--     FOREIGN KEY (borrowing_id) REFERENCES borrowings(borrowing_id),
--     FOREIGN KEY (processed_by) REFERENCES staff(staff_id)
-- );

-- -- Table for reservations
-- CREATE TABLE reservations (
--     reservation_id INT AUTO_INCREMENT PRIMARY KEY,
--     book_id INT NOT NULL,
--     student_id VARCHAR(10) NOT NULL,
--     reservation_date DATETIME NOT NULL,
--     expiry_date DATETIME NOT NULL,
--     status ENUM('Pending', 'Fulfilled', 'Cancelled', 'Expired') NOT NULL DEFAULT 'Pending',
--     FOREIGN KEY (book_id) REFERENCES books(book_id),
--     FOREIGN KEY (student_id) REFERENCES students(student_id)
-- );

-- -- Table for system users (for login)
-- CREATE TABLE users (
--     user_id VARCHAR(10) PRIMARY KEY,
--     username VARCHAR(50) UNIQUE NOT NULL,
--     password_hash VARCHAR(255) NOT NULL,
--     role ENUM('Librarian', 'Assistant', 'Admin') NOT NULL,
--     last_login DATETIME,
--     is_active BOOLEAN DEFAULT TRUE,
--     FOREIGN KEY (user_id) REFERENCES staff(staff_id) ON DELETE CASCADE
-- );

-- -- Table for system logs/audit trail
-- CREATE TABLE audit_log (
--     log_id INT AUTO_INCREMENT PRIMARY KEY,
--     user_id VARCHAR(10),
--     action VARCHAR(50) NOT NULL,
--     table_affected VARCHAR(50) NOT NULL,
--     record_id VARCHAR(50),
--     old_value TEXT,
--     new_value TEXT,
--     action_time DATETIME NOT NULL,
--     ip_address VARCHAR(45),
--     FOREIGN KEY (user_id) REFERENCES users(user_id)
-- );

-- -- Insert sample categories
-- INSERT INTO categories (name, description) VALUES
-- ('Mathematics', 'Books covering mathematics topics for high school'),
-- ('English', 'English language and literature books'),
-- ('Kiswahili', 'Kiswahili language and literature books'),
-- ('Science', 'Biology, Chemistry, Physics and General Science'),
-- ('History', 'Kenyan and world history books'),
-- ('Geography', 'Geography and environmental studies'),
-- ('Religious Education', 'CRE and IRE books'),
-- ('Business Studies', 'Commerce, accounting and business books'),
-- ('Agriculture', 'Agriculture and farming books'),
-- ('Reference', 'Dictionaries, encyclopedias and other reference materials');

-- -- Insert sample publishers
-- INSERT INTO publishers (name, address, contact_phone, contact_email) VALUES
-- ('Longhorn Publishers', 'P.O. Box 18033-00500, Nairobi', '+254722000000', 'info@longhornpublishers.com'),
-- ('Oxford University Press', 'P.O. Box 72532-00200, Nairobi', '+254733000000', 'customercare@oup.co.ke'),
-- ('East African Educational Publishers', 'P.O. Box 45314-00100, Nairobi', '+254722111111', 'info@eastafricanpublishers.com'),
-- ('KLB Publishers', 'P.O. Box 66933-00200, Nairobi', '+254733222222', 'customercare@klb.co.ke'),
-- ('Moran Publishers', 'P.O. Box 30797-00100, Nairobi', '+254722333333', 'info@moranpublishers.com');

-- -- Insert sample authors
-- INSERT INTO authors (first_name, last_name, nationality) VALUES
-- ('David', 'Mulwa', 'Kenyan'),
-- ('Ngugi wa', 'Thiongo', 'Kenyan'),
-- ('Francis', 'Imbuga', 'Kenyan'),
-- ('William', 'Shakespeare', 'British'),
-- ('Chinua', 'Achebe', 'Nigerian');

-- -- First insert the staff members
-- INSERT INTO staff (staff_id, national_id, first_name, last_name, gender, email, phone, role, hire_date) VALUES
-- ('LIB001', '12345678', 'Jane', 'Mwangi', 'Female', 'jane.mwangi@school.edu', '0722000001', 'Librarian', '2020-01-10'),
-- ('LIB002', '23456789', 'John', 'Kamau', 'Male', 'john.kamau@school.edu', '0722000002', 'Assistant', '2021-03-15');

-- -- Then insert the books
-- INSERT INTO books (isbn, title, edition, category_id, publisher_id, publication_year, pages, language, date_added, added_by) VALUES
-- ('978-9966-49-654-5', 'Secondary Mathematics Student Book 1', '4th', 1, 1, 2018, 256, 'English', '2023-01-15', 'LIB001'),
-- ('978-019-573775-4', 'Head Start Secondary English Form 1', '2nd', 2, 2, 2019, 180, 'English', '2023-01-20', 'LIB001'),
-- ('978-9966-25-931-0', 'Kiswahili Kitukuzwe Kidato Cha 1', '3rd', 3, 3, 2020, 200, 'Kiswahili', '2023-02-05', 'LIB001'),
-- ('978-9966-49-822-8', 'Secondary Biology Student Book 1', '1st', 4, 4, 2017, 240, 'English', '2023-02-10', 'LIB001');
INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1),
(2, 4),
(3, 2),
(4, 3);

-- Insert book copies
INSERT INTO book_copies (book_id, barcode, acquisition_date, shelf_location, status) VALUES
(1, 'MATH1-001', '2023-01-16', 'Shelf A1', 'Available'),
(1, 'MATH1-002', '2023-01-16', 'Shelf A1', 'Available'),
(2, 'ENG1-001', '2023-01-21', 'Shelf B2', 'Available'),
(3, 'KIS1-001', '2023-02-06', 'Shelf C3', 'Available'),
(4, 'BIO1-001', '2023-02-11', 'Shelf D4', 'Available');

-- Insert sample staff
INSERT INTO staff (staff_id, national_id, first_name, last_name, gender, email, phone, role, hire_date) VALUES
('LIB001', '12345678', 'Jane', 'Mwangi', 'Female', 'jane.mwangi@school.edu', '0722000001', 'Librarian', '2020-01-10'),
('LIB002', '23456789', 'John', 'Kamau', 'Male', 'john.kamau@school.edu', '0722000002', 'Assistant', '2021-03-15');

-- Insert sample students
INSERT INTO students (student_id, admission_number, first_name, last_name, form_level, stream, gender, date_of_birth, registration_date) VALUES
('F1A001', '2023F1A001', 'Ann', 'Wambui', '1', 'A', 'Female', '2008-05-12', '2023-01-10'),
('F1A002', '2023F1A002', 'Peter', 'Maina', '1', 'A', 'Male', '2008-07-23', '2023-01-10'),
('F2B001', '2022F2B001', 'James', 'Mutua', '2', 'B', 'Male', '2007-03-15', '2022-01-12'),
('F3C001', '2021F3C001', 'Susan', 'Atieno', '3', 'C', 'Female', '2006-11-05', '2021-01-08'),
('F4D001', '2020F4D001', 'David', 'Ochieng', '4', 'D', 'Male', '2005-09-30', '2020-01-15');

-- Insert sample users
INSERT INTO users (user_id, username, password_hash, role) VALUES
('LIB001', 'jane.mwangi', SHA2('library123', 256), 'Librarian'),
('LIB002', 'john.kamau', SHA2('library456', 256), 'Assistant');