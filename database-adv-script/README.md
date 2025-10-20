# Complex Queries with Joins

## Objective
Master SQL joins by writing complex queries using different types of joins.

## Queries Implemented

### 1. INNER JOIN - Bookings with User Details
This query retrieves all bookings and the respective users who made those bookings. It uses an INNER JOIN to ensure only bookings with matching users are returned.

**Key Features:**
- Combines Booking and User tables
- Returns only matching records from both tables
- Ordered by booking creation date (most recent first)

### 2. LEFT JOIN - Properties with Reviews
This query retrieves all properties and their reviews, including properties that have no reviews. The LEFT JOIN ensures all properties are included even if they haven't been reviewed.

**Key Features:**
- Combines Property, Review, and User tables
- Includes all properties, even those without reviews
- Shows reviewer information when available
- Ordered by property ID and review date

### 3. FULL OUTER JOIN - Users and Bookings
This query retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.

**Implementation Note:**
Since MySQL doesn't support FULL OUTER JOIN directly, this is implemented using a UNION of LEFT JOIN and RIGHT JOIN to achieve the same result.

**Key Features:**
- Shows all users, including those without bookings
- Shows all bookings, including orphaned bookings (if any)
- Ordered by user ID and booking ID

## Usage
Run these queries against your Airbnb database to analyze relationships between users, bookings, properties, and reviews.

## Database Tables Referenced
- User
- Booking
- Property
- Review