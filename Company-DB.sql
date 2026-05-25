-- 1. Create DEPARTMENT table first (needed for Employee)
CREATE TABLE DEPARTMENT (
    DNUM INT PRIMARY KEY,
    DName VARCHAR(50) NOT NULL UNIQUE,
    ManagerSSN VARCHAR(15),
    ManagerHiringDate DATE
);

-- 2. Create EMPLOYEE table
-- Note: SuperSSN is a self-referencing foreign key for supervision
CREATE TABLE EMPLOYEE (
    SSN VARCHAR(15) PRIMARY KEY,
    Fname VARCHAR(20) NOT NULL,
    Lname VARCHAR(20) NOT NULL,
    Bdate DATE,
    Gender CHAR(1),
    DNUM INT,
    SuperSSN VARCHAR(15),
    FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNUM),
    FOREIGN KEY (SuperSSN) REFERENCES EMPLOYEE(SSN)
);

-- 3. Add Foreign Key for Manager in DEPARTMENT table
ALTER TABLE DEPARTMENT 
ADD FOREIGN KEY (ManagerSSN) REFERENCES EMPLOYEE(SSN);

-- 4. Create PROJECT table
CREATE TABLE PROJECT (
    PNumber INT PRIMARY KEY,
    PName VARCHAR(50) NOT NULL,
    Location VARCHAR(50),
    City VARCHAR(50),
    DNUM INT NOT NULL,
    FOREIGN KEY (DNUM) REFERENCES DEPARTMENT(DNUM)
);

-- 5. Create WORKS_ON table (Associative table for M:N relationship)
CREATE TABLE WORKS_ON (
    ESSN VARCHAR(15),
    PNumber INT,
    Hours DECIMAL(5,2),
    PRIMARY KEY (ESSN, PNumber),
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNumber) REFERENCES PROJECT(PNumber)
);

-- 6. Create DEPENDENT table (Weak entity)
-- ON DELETE CASCADE ensures dependent info is deleted if employee leaves
CREATE TABLE DEPENDENT (
    ESSN VARCHAR(15),
    DepName VARCHAR(50),
    Gender CHAR(1),
    Bdate DATE,
    PRIMARY KEY (ESSN, DepName),
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE
);