-- Create the Authors table to store author details
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT, -- Primary key, auto-incremented
    first_name VARCHAR(50) NOT NULL, -- Author's first name, not null
    last_name VARCHAR(50) NOT NULL, -- Author's last name, not null
    email VARCHAR(100) UNIQUE -- Author's email, unique but nullable
);

-- Create the Book_Authors table to handle the many-to-many relationship between Books and Authors
CREATE TABLE Book_Authors (
    book_id INT, -- Foreign key referencing Books
    author_id INT, -- Foreign key referencing Authors
    PRIMARY KEY (book_id, author_id), -- Composite primary key
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE, -- FK constraint, cascade delete
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE -- FK constraint, cascade delete
);

-- Create the Members table to store library member details
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT, -- Primary key, auto-incremented
    first_name VARCHAR(50) NOT NULL, -- Member's first name, not null
    last_name VARCHAR(50) NOT NULL, -- Member's last name, not null
    email VARCHAR(100) NOT NULL UNIQUE, -- Member's email, unique and not null
    join_date DATE NOT NULL -- Date the member joined, not null
);

-- Create the Borrowings table to track books borrowed by members
CREATE TABLE Borrowings (
    borrowing_id INT PRIMARY KEY AUTO_INCREMENT, -- Primary key, auto-incremented
    member_id INT, -- Foreign key referencing Members
    book_id INT, -- Foreign key referencing Books
    borrow_date DATE NOT NULL, -- Date the book was borrowed, not null
    due_date DATE NOT NULL, -- Due date for return, not null
    return_date DATE, -- Date the book was returned, nullable
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE, -- FK constraint, cascade delete
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE, -- FK constraint, cascade delete
    CHECK (due_date >= borrow_date) -- Ensure due date is on or after borrow date
);