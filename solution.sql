-- P1: Table Creation and Sample Data
CREATE DATABASE IF NOT EXISTS BookMyShowDB;
USE BookMyShowDB;

-- 1. Theater Table
CREATE TABLE Theater (
    theater_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255)
);

-- 2. Movie Table
CREATE TABLE Movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    certification VARCHAR(10), -- e.g., UA, A, U
    language VARCHAR(50)
);

-- 3. Screen Table
CREATE TABLE Screen (
    screen_id INT AUTO_INCREMENT PRIMARY KEY,
    theater_id INT,
    screen_number INT,
    sound_format VARCHAR(100), -- e.g., Dolby 7.1, 4K Atmos
    FOREIGN KEY (theater_id) REFERENCES Theater(theater_id)
);

-- 4. Show Table (Normalized to handle individual timings)
CREATE TABLE Shows (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    screen_id INT,
    movie_id INT,
    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    FOREIGN KEY (screen_id) REFERENCES Screen(screen_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(movie_id)
);

-- Insert Sample Data based on provided image
INSERT INTO Theater (name, location) VALUES ('PVR: Nexus', 'Forum Mall');

INSERT INTO Movie (title, certification, language) VALUES 
('Dasara', 'UA', 'Telugu'),
('Kisi Ka Bhai Kisi Ki Jaan', 'UA', 'Hindi'),
('Tu Jhoothi Main Makkaar', 'UA', 'Hindi'),
('Avatar: The Way of Water', 'UA', 'English');

INSERT INTO Screen (theater_id, screen_number, sound_format) VALUES 
(1, 1, '4K Dolby 7.1'),
(1, 2, '4K ATMOS'),
(1, 3, 'Playhouse 4K');

INSERT INTO Shows (screen_id, movie_id, show_date, start_time) VALUES 
(1, 1, '2026-04-25', '12:15:00'), -- Dasara
(2, 2, '2026-04-25', '13:00:00'), -- Kisi Ka Bhai...
(2, 2, '2026-04-25', '16:10:00'),
(2, 2, '2026-04-25', '19:20:00'),
(1, 3, '2026-04-25', '13:15:00'), -- Tu Jhoothi...
(3, 4, '2026-04-25', '13:20:00'); -- Avatar

-- P2: Query to list all shows on a given date at a given theatre
-- Example: Get shows for 'PVR: Nexus' on '2026-04-25'
SELECT 
    m.title AS Movie,
    m.language AS Language,
    s.start_time AS Show_Time,
    sc.sound_format AS Tech_Specs
FROM Shows s
JOIN Movie m ON s.movie_id = m.movie_id
JOIN Screen sc ON s.screen_id = sc.screen_id
JOIN Theater t ON sc.theater_id = t.theater_id
WHERE t.name = 'PVR: Nexus' 
  AND s.show_date = '2026-04-25'
ORDER BY m.title, s.start_time;