-- Task 3: Implement Indexes for Optimization
-- This file contains CREATE INDEX commands for improving query performance

-- Indexes for User Table
-- Index on email for login queries and user lookups
CREATE INDEX idx_user_email ON User(email);

-- Index on phone_number for contact lookups
CREATE INDEX idx_user_phone ON User(phone_number);

-- Index on created_at for filtering users by registration date
CREATE INDEX idx_user_created_at ON User(created_at);

-- Indexes for Booking Table
-- Index on user_id for finding all bookings by a specific user (used in JOINs and WHERE clauses)
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on property_id for finding all bookings for a specific property
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on start_date for date range queries and sorting
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Index on end_date for date range queries
CREATE INDEX idx_booking_end_date ON Booking(end_date);

-- Index on status for filtering bookings by status (pending, confirmed, canceled)
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite index for date range queries (most common query pattern)
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Composite index for user bookings with status filtering
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);

-- Index on created_at for sorting by booking creation time
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Indexes for Property Table
-- Index on host_id for finding all properties owned by a host
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on location for searching properties by location
CREATE INDEX idx_property_location ON Property(location);

-- Index on pricepernight for filtering and sorting by price
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Composite index for location and price queries
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);

-- Index on created_at for sorting by property listing date
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Indexes for Review Table
-- Index on property_id for finding all reviews for a property
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on user_id for finding all reviews by a user
CREATE INDEX idx_review_user_id ON Review(user_id);

-- Index on rating for filtering by rating score
CREATE INDEX idx_review_rating ON Review(rating);

-- Composite index for property reviews with ratings
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Index on created_at for sorting reviews by date
CREATE INDEX idx_review_created_at ON Review(created_at);

-- Indexes for Payment Table
-- Index on booking_id for finding payment for a specific booking
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- Index on payment_method for filtering by payment type
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Index on payment_date for date-based queries
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Composite index for booking payment status queries
CREATE INDEX idx_payment_booking_date ON Payment(booking_id, payment_date);

-- Indexes for Message Table (if exists)
-- Index on sender_id for finding all messages sent by a user
CREATE INDEX idx_message_sender_id ON Message(sender_id);

-- Index on recipient_id for finding all messages received by a user
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);

-- Index on sent_at for sorting messages by date
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- Composite index for user conversations
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);