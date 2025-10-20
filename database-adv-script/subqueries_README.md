# Practice Subqueries

## Objective
Write both correlated and non-correlated subqueries to analyze data in the Airbnb database.

## Queries Implemented

### 1. Non-Correlated Subquery - Properties with Average Rating > 4.0
This query finds all properties where the average rating is greater than 4.0 using a subquery.

**Key Features:**
- Uses a subquery in the WHERE clause to filter properties
- Groups reviews by property to calculate average ratings
- Uses HAVING clause to filter groups with average rating > 4.0
- Additional subquery in SELECT to display the average rating
- Results ordered by average rating (highest first)

**Type:** Non-correlated subquery (subquery executes once independently)

### 2. Correlated Subquery - Users with More Than 3 Bookings
This query finds users who have made more than 3 bookings using a correlated subquery.

**Key Features:**
- Uses a correlated subquery that references the outer query's User table
- Subquery executes for each user in the outer query
- Counts bookings for each specific user
- Filters users with more than 3 bookings
- Additional correlated subquery in SELECT to display total bookings count
- Results ordered by total bookings (highest first)

**Type:** Correlated subquery (subquery executes for each row in outer query)

## Difference Between Query Types

### Non-Correlated Subquery
- Executes independently of the outer query
- Runs once and returns results used by the outer query
- Generally more efficient for large datasets

### Correlated Subquery
- References columns from the outer query
- Executes once for each row processed by the outer query
- Can be less efficient but allows for more complex row-by-row comparisons

## Usage
Run these queries against your Airbnb database to identify high-rated properties and frequent users.

## Database Tables Referenced
- Property
- Review
- User
- Booking