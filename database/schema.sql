-- Drop existing tables if they exist
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Attendances;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Memberships;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Instructors;
DROP TABLE IF EXISTS Bookings;

-- Create Members table
CREATE TABLE Members (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Use IDENTITY for auto-increment in SQL Server
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    membership_start DATE NOT NULL,
    membership_end DATE NOT NULL,
    created_at DATETIME DEFAULT GETDATE()  -- Use GETDATE() for current timestamp
);

-- Create Instructors table
CREATE TABLE Instructors (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    created_at DATETIME DEFAULT GETDATE()
);

-- Create Classes table
CREATE TABLE Classes (
    id INT PRIMARY KEY IDENTITY(1,1),
    class_name VARCHAR(100) NOT NULL,
    instructor_id INT NULL,
    schedule VARCHAR(100),
    capacity INT,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(id) ON DELETE SET NULL
);

-- Create Memberships table
CREATE TABLE Memberships (
    id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL,
    membership_type VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE
);

-- Create Bookings table
CREATE TABLE Bookings (
    id INT PRIMARY KEY IDENTITY(1,1),
    class_id INT NOT NULL,
    member_id INT NOT NULL,
    booking_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (class_id) REFERENCES Classes(id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE
);

-- Create Payments table
CREATE TABLE Payments (
    id INT PRIMARY KEY IDENTITY(1,1),
    member_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    method VARCHAR(50),
    FOREIGN KEY (member_id) REFERENCES Members(id) ON DELETE CASCADE
);

-- Create Attendances table
CREATE TABLE Attendances (
    id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    attended BIT DEFAULT 0,  -- Use BIT for Boolean values in SQL Server
    attendance_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (booking_id) REFERENCES Bookings(id) ON DELETE CASCADE
);

-- Create Equipment table
CREATE TABLE Equipment (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(50) DEFAULT 'available',
    created_at DATETIME DEFAULT GETDATE()
);

-- Insert initial data into Members table
INSERT INTO Members (name, email, phone, membership_start, membership_end) VALUES
('John Doe', 'john@example.com', '123-456-7890', '2024-01-01', '2025-01-01'),
('Jane Smith', 'jane@example.com', '098-765-4321', '2024-02-01', '2025-02-01');

-- Insert initial data into Instructors table
INSERT INTO Instructors (name, specialization, phone) VALUES
('Mike Johnson', 'Yoga', '555-123-4567'),
('Emily Davis', 'Pilates', '555-987-6543');

-- Insert initial data into Classes table
INSERT INTO Classes (class_name, instructor_id, schedule, capacity) VALUES
('Morning Yoga', 1, 'Monday 7:00 AM', 20),
('Evening Pilates', 2, 'Wednesday 6:00 PM', 15);

-- Insert initial data into Memberships table
INSERT INTO Memberships (member_id, membership_type, start_date, end_date) VALUES
(1, 'Monthly', '2024-01-01', '2024-01-31'),
(2, 'Annual', '2024-02-01', '2025-02-01');

-- Insert initial data into Bookings table
INSERT INTO Bookings (class_id, member_id) VALUES
(1, 1),
(2, 2);

-- Insert initial data into Payments table
INSERT INTO Payments (member_id, amount, method) VALUES
(1, 29.99, 'Credit Card'),
(2, 199.99, 'Bank Transfer');

-- Insert initial data into Attendances table
INSERT INTO Attendances (booking_id, attended) VALUES
(1, 1),
(2, 0);

-- Insert initial data into Equipment table
INSERT INTO Equipment (name, quantity, status) VALUES
('Treadmill', 10, 'available'),
('Dumbbells', 20, 'available'),
('Yoga Mats', 15, 'available');
