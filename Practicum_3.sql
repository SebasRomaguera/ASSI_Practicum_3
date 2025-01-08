-- Crear la base de datos
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- Crear tabla para estudiantes
CREATE TABLE Students (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    PRIMARY KEY (StudentID)
);

-- Crear tabla para cursos
CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(100),
    Credits INT,
    PRIMARY KEY (CourseID)
);

-- Crear tabla para profesores
CREATE TABLE Professors (
    ProfessorID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PRIMARY KEY (ProfessorID)
);

-- Crear tabla para asignaciones (relación entre profesores y cursos)
CREATE TABLE CourseAssignments (
    CourseID INT,
    ProfessorID INT,
    PRIMARY KEY (CourseID, ProfessorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
);

-- Crear tabla para inscripciones (relación entre estudiantes y cursos)
CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade DECIMAL(5, 2),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
        ON DELETE CASCADE
        ON UPDATE SET NULL
);

-- Insertar datos en las tablas
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth)
VALUES (1, 'Alice', 'Smith', '2000-05-15'),
       (2, 'Bob', 'Johnson', '1999-03-22');

INSERT INTO Professors (ProfessorID, FirstName, LastName)
VALUES (1, 'Dr. John', 'Doe'),
       (2, 'Dr. Jane', 'Brown');

INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES (101, 'Mathematics', 3),
       (102, 'Physics', 4);

INSERT INTO CourseAssignments (CourseID, ProfessorID)
VALUES (101, 1),
       (102, 2);

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade)
VALUES (1, 101, '2023-09-01', 95.00),
       (2, 102, '2023-09-01', 88.00);

-- Crear una vista para mostrar los estudiantes y los cursos a los que están inscritos
CREATE VIEW StudentCourseView AS
SELECT 
    s.StudentID,
    s.FirstName AS StudentFirstName,
    s.LastName AS StudentLastName,
    c.CourseName,
    e.EnrollmentDate,
    e.Grade
FROM 
    Students s
JOIN 
    Enrollments e ON s.StudentID = e.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID;

-- Crear una vista para mostrar los cursos y los profesores asignados
CREATE VIEW CourseProfessorView AS
SELECT 
    c.CourseID,
    c.CourseName,
    p.FirstName AS ProfessorFirstName,
    p.LastName AS ProfessorLastName
FROM 
    Courses c
JOIN 
    CourseAssignments ca ON c.CourseID = ca.CourseID
JOIN 
    Professors p ON ca.ProfessorID = p.ProfessorID;

-- Consultar las vistas
SELECT * FROM StudentCourseView;
SELECT * FROM CourseProfessorView;
--***********************************************************************************************************
--Para el drop database solo seria borrarla
-- drop SchoolDB