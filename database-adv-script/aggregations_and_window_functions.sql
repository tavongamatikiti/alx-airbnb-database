-- Task 2: Apply Aggregations and Window Functions
-- This file contains queries using aggregation functions and window functions

-- Query 1: Find the total number of bookings made by each user using COUNT and GROUP BY
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_spent,
    AVG(b.total_price) AS average_booking_price,
    MIN(b.start_date) AS first_booking_date,
    MAX(b.start_date) AS last_booking_date
FROM
    User u
LEFT JOIN
    Booking b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name, u.email
HAVING
    COUNT(b.booking_id) > 0
ORDER BY
    total_bookings DESC, total_spent DESC;

-- Query 2: Use ROW_NUMBER to rank properties based on total number of bookings
SELECT
    property_id,
    property_name,
    total_bookings,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC, total_revenue DESC) AS row_rank
FROM (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings,
        COALESCE(SUM(b.total_price), 0) AS total_revenue
    FROM
        Property p
    LEFT JOIN
        Booking b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
) AS property_stats
ORDER BY
    row_rank;

-- Query 3: Use RANK to rank properties based on total number of bookings
-- RANK allows for ties and skips rankings after ties
SELECT
    property_id,
    property_name,
    total_bookings,
    total_revenue,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS dense_booking_rank
FROM (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings,
        COALESCE(SUM(b.total_price), 0) AS total_revenue
    FROM
        Property p
    LEFT JOIN
        Booking b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
) AS property_stats
ORDER BY
    booking_rank;

-- Additional Query: Using PARTITION BY with window functions
-- Rank properties within each location
SELECT
    p.property_id,
    p.name AS property_name,
    p.location,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS location_rank,
    ROW_NUMBER() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS location_row_number
FROM
    Property p
LEFT JOIN
    Booking b ON p.property_id = b.property_id
GROUP BY
    p.property_id, p.name, p.location
ORDER BY
    p.location, location_rank;