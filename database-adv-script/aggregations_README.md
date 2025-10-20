# Apply Aggregations and Window Functions

## Objective
Use SQL aggregation and window functions to analyze data in the Airbnb database.

## Queries Implemented

### 1. Aggregation Functions - User Booking Statistics
This query finds the total number of bookings made by each user using COUNT and GROUP BY, along with additional aggregate statistics.

**Key Features:**
- `COUNT(b.booking_id)`: Total number of bookings per user
- `SUM(b.total_price)`: Total amount spent by each user
- `AVG(b.total_price)`: Average booking price per user
- `MIN(b.start_date)`: First booking date
- `MAX(b.start_date)`: Most recent booking date
- Uses LEFT JOIN to include all users (even those without bookings)
- HAVING clause filters to show only users with bookings
- Results ordered by total bookings and total spent

**Use Case:** Identify most active and valuable customers

### 2. Window Function - ROW_NUMBER Ranking
This query uses ROW_NUMBER() window function to rank properties based on total bookings and revenue.

**Key Features:**
- `ROW_NUMBER()`: Assigns unique sequential numbers to each property
- No duplicate ranks (1, 2, 3, 4, 5...)
- Ordered by total bookings and total revenue
- Useful when you need unique ranking without ties

**Use Case:** Create a definitive top properties list

### 3. Window Function - RANK and DENSE_RANK
This query demonstrates the difference between RANK() and DENSE_RANK() functions.

**Key Features:**
- `RANK()`: Allows ties, skips rankings after ties (1, 2, 2, 4, 5...)
- `DENSE_RANK()`: Allows ties, doesn't skip rankings (1, 2, 2, 3, 4...)
- Both ordered by total bookings

**Use Case:** Ranking with ties when multiple properties have same booking count

### 4. Window Function with PARTITION BY
This advanced query ranks properties within each location using PARTITION BY.

**Key Features:**
- `PARTITION BY p.location`: Creates separate ranking groups for each location
- `RANK()` and `ROW_NUMBER()` applied independently within each location
- Shows top properties per location/city
- Useful for regional performance analysis

**Use Case:** Identify best-performing properties in each city

## Window Functions vs Aggregations

### Aggregation Functions
- Reduce multiple rows to a single summary row
- Require GROUP BY clause
- Examples: COUNT, SUM, AVG, MIN, MAX

### Window Functions
- Perform calculations across a set of rows related to the current row
- Don't reduce the number of rows
- Can use PARTITION BY to create groups
- Examples: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD

## Usage
Run these queries against your Airbnb database to analyze user behavior and property performance.

## Database Tables Referenced
- User
- Booking
- Property