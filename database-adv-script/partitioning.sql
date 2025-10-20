-- Task 5: Partitioning Large Tables
-- This file contains SQL commands to implement table partitioning on the Booking table

-- Step 1: Check current Booking table structure
-- SHOW CREATE TABLE Booking;

-- Step 2: Create a new partitioned Booking table
-- Note: In MySQL, you cannot directly partition an existing table with data
-- You need to either use ALTER TABLE or create a new table and migrate data

-- Option 1: ALTER TABLE to add partitioning (if table exists without partitioning)
-- This approach works if the table is not too large
ALTER TABLE Booking
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_2020 VALUES LESS THAN (2021),
    PARTITION p_2021 VALUES LESS THAN (2022),
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Option 2: Create new partitioned table from scratch
-- Use this approach if you need to create the table initially with partitioning

CREATE TABLE Booking_Partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_date (start_date),
    INDEX idx_status (status),

    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_2020 VALUES LESS THAN (2021),
    PARTITION p_2021 VALUES LESS THAN (2022),
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_2024 VALUES LESS THAN (2025),
    PARTITION p_2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Step 3: Migrate data from old table to partitioned table (if using Option 2)
-- INSERT INTO Booking_Partitioned SELECT * FROM Booking;

-- Step 4: Rename tables to replace old with new (if using Option 2)
-- RENAME TABLE Booking TO Booking_Old, Booking_Partitioned TO Booking;

-- Alternative Partitioning Strategy: By Quarter
-- This provides more granular partitioning for better performance on smaller date ranges

CREATE TABLE Booking_Quarterly (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_start_date (start_date),
    INDEX idx_status (status),

    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
)
PARTITION BY RANGE (TO_DAYS(start_date)) (
    PARTITION p_2023_q1 VALUES LESS THAN (TO_DAYS('2023-04-01')),
    PARTITION p_2023_q2 VALUES LESS THAN (TO_DAYS('2023-07-01')),
    PARTITION p_2023_q3 VALUES LESS THAN (TO_DAYS('2023-10-01')),
    PARTITION p_2023_q4 VALUES LESS THAN (TO_DAYS('2024-01-01')),
    PARTITION p_2024_q1 VALUES LESS THAN (TO_DAYS('2024-04-01')),
    PARTITION p_2024_q2 VALUES LESS THAN (TO_DAYS('2024-07-01')),
    PARTITION p_2024_q3 VALUES LESS THAN (TO_DAYS('2024-10-01')),
    PARTITION p_2024_q4 VALUES LESS THAN (TO_DAYS('2025-01-01')),
    PARTITION p_2025_q1 VALUES LESS THAN (TO_DAYS('2025-04-01')),
    PARTITION p_2025_q2 VALUES LESS THAN (TO_DAYS('2025-07-01')),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Test Queries for Partitioned Tables

-- Query 1: Fetch bookings for a specific year (will only scan one partition)
SELECT *
FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Query 2: Fetch bookings for a date range within a single year
SELECT *
FROM Booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-08-31'
  AND status = 'confirmed';

-- Query 3: Fetch bookings for a date range spanning multiple years
SELECT *
FROM Booking
WHERE start_date BETWEEN '2023-12-01' AND '2024-02-28';

-- Query 4: Count bookings per year (partition pruning will optimize this)
SELECT YEAR(start_date) AS booking_year, COUNT(*) AS total_bookings
FROM Booking
GROUP BY YEAR(start_date)
ORDER BY booking_year;

-- View partition information
SELECT
    PARTITION_NAME,
    TABLE_ROWS,
    AVG_ROW_LENGTH,
    DATA_LENGTH
FROM
    INFORMATION_SCHEMA.PARTITIONS
WHERE
    TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'Booking';

-- Analyze partition usage
EXPLAIN PARTITIONS
SELECT *
FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Maintenance: Add new partition for future year
ALTER TABLE Booking
REORGANIZE PARTITION p_future INTO (
    PARTITION p_2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Maintenance: Drop old partition (be careful - this deletes data!)
-- ALTER TABLE Booking DROP PARTITION p_2020;

-- Maintenance: Optimize specific partition
-- ALTER TABLE Booking OPTIMIZE PARTITION p_2024;