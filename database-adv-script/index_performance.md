# Index Performance Analysis

## Objective
Identify and create indexes to improve query performance on the Airbnb database.

## High-Usage Columns Identified

### User Table
- **email**: Frequently used in login queries and user lookups (WHERE clause)
- **phone_number**: Used for contact information searches
- **created_at**: Used for filtering users by registration date (ORDER BY, WHERE)

### Booking Table
- **user_id**: High usage in JOINs with User table and filtering bookings by user
- **property_id**: High usage in JOINs with Property table and filtering bookings by property
- **start_date**: Frequently used in date range queries and sorting (WHERE, ORDER BY)
- **end_date**: Used in date range queries for availability checks
- **status**: Common filter for booking status (pending, confirmed, canceled)
- **created_at**: Used for sorting bookings chronologically

### Property Table
- **host_id**: Used in JOINs and filtering properties by host
- **location**: Frequently searched/filtered by users looking for properties
- **pricepernight**: Used in range queries and sorting by price (WHERE, ORDER BY)
- **created_at**: Used for sorting by listing date

### Review Table
- **property_id**: Used in JOINs and filtering reviews by property
- **user_id**: Used in JOINs and filtering reviews by user
- **rating**: Frequently used in aggregate functions and filtering (AVG, WHERE)
- **created_at**: Used for sorting reviews by date

### Payment Table
- **booking_id**: Primary join key with Booking table
- **payment_method**: Filter for payment type analysis
- **payment_date**: Used in date range queries and reporting

## Indexes Created

### Single-Column Indexes
Created for columns frequently used in:
- WHERE clauses
- JOIN conditions
- ORDER BY clauses
- Aggregate functions

### Composite Indexes
Created for common query patterns that filter on multiple columns:
- `idx_booking_dates`: (start_date, end_date) - for date range queries
- `idx_booking_user_status`: (user_id, status) - for user bookings with status filter
- `idx_property_location_price`: (location, pricepernight) - for location + price searches
- `idx_review_property_rating`: (property_id, rating) - for property reviews analysis
- `idx_message_conversation`: (sender_id, recipient_id, sent_at) - for message threads

## Performance Measurement Methodology

### Before Indexing
```sql
EXPLAIN ANALYZE
SELECT b.*, u.first_name, u.last_name
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id
WHERE b.start_date >= '2024-01-01'
  AND b.status = 'confirmed'
ORDER BY b.start_date;
```

**Expected Results (Without Indexes):**
- Type: ALL (full table scan)
- Rows examined: Entire table
- Execution time: High (varies with table size)
- Using filesort: Yes

### After Indexing
```sql
-- Run the same query after creating indexes
EXPLAIN ANALYZE
SELECT b.*, u.first_name, u.last_name
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id
WHERE b.start_date >= '2024-01-01'
  AND b.status = 'confirmed'
ORDER BY b.start_date;
```

**Expected Results (With Indexes):**
- Type: ref or range
- Rows examined: Significantly reduced
- Execution time: Much lower
- Using index: Yes (idx_booking_dates, idx_booking_user_status)

## Performance Improvements Expected

### Query 1: Find bookings by date range
**Before:** Full table scan on Booking table
**After:** Index scan using `idx_booking_start_date` or `idx_booking_dates`
**Expected Improvement:** 70-90% reduction in query time

### Query 2: Find all properties in a location within price range
**Before:** Full table scan on Property table
**After:** Index scan using `idx_property_location_price`
**Expected Improvement:** 60-85% reduction in query time

### Query 3: Calculate average rating for a property
**Before:** Full table scan on Review table
**After:** Index scan using `idx_review_property_rating`
**Expected Improvement:** 75-95% reduction in query time

### Query 4: Find user bookings with specific status
**Before:** Full table scan on Booking table
**After:** Index scan using `idx_booking_user_status`
**Expected Improvement:** 65-90% reduction in query time

## Testing Commands

### Measure Query Performance
```sql
-- Enable profiling
SET profiling = 1;

-- Run your query
SELECT * FROM Booking WHERE start_date >= '2024-01-01';

-- Show profile
SHOW PROFILES;

-- Detailed profile for last query
SHOW PROFILE FOR QUERY 1;
```

### Analyze Query Execution Plan
```sql
EXPLAIN SELECT * FROM Booking
WHERE start_date >= '2024-01-01'
  AND status = 'confirmed';
```

### Check Index Usage
```sql
SHOW INDEX FROM Booking;
```

### Analyze Index Statistics
```sql
ANALYZE TABLE Booking;
SHOW INDEX FROM Booking;
```

## Recommendations

1. **Monitor Index Usage**: Regularly check which indexes are being used with `SHOW INDEX FROM table_name`
2. **Avoid Over-Indexing**: Too many indexes can slow down INSERT, UPDATE, and DELETE operations
3. **Composite Index Order**: Place the most selective column first in composite indexes
4. **Update Statistics**: Run `ANALYZE TABLE` regularly to keep index statistics current
5. **Review Slow Queries**: Use slow query log to identify queries that need optimization
6. **Consider Covering Indexes**: For frequently run queries, create indexes that include all columns in the SELECT clause

## Maintenance

- Regularly rebuild indexes using `OPTIMIZE TABLE` for fragmented tables
- Monitor index size and performance impact
- Remove unused indexes identified through performance monitoring
- Update indexes when query patterns change

## Conclusion

Proper indexing significantly improves query performance, especially on large tables. The indexes created target the most common query patterns in an Airbnb-style application, including:
- User authentication and lookups
- Booking searches and filtering
- Property searches by location and price
- Review aggregations and analysis
- Payment tracking and reporting

Regular monitoring and maintenance ensure indexes continue to provide optimal performance as data grows.