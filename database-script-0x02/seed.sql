-- Seed data for Airbnb database

-- Insert Users
INSERT INTO users (name, email, phone) VALUES
('John Doe', 'john.doe@email.com', '+1234567890'),
('Jane Smith', 'jane.smith@email.com', '+1234567891'),
('Mike Johnson', 'mike.johnson@email.com', '+1234567892'),
('Sarah Williams', 'sarah.williams@email.com', '+1234567893'),
('David Brown', 'david.brown@email.com', '+1234567894');

-- Insert Listings
INSERT INTO listings (user_id, title, description, price, location) VALUES
(1, 'Cozy Downtown Apartment', 'Beautiful 2-bedroom apartment in the heart of the city', 120.00, 'New York, NY'),
(2, 'Beach House Getaway', 'Stunning oceanfront property with private beach access', 250.00, 'Miami, FL'),
(1, 'Mountain Cabin Retreat', 'Peaceful cabin surrounded by nature and hiking trails', 180.00, 'Colorado Springs, CO'),
(3, 'Modern City Loft', 'Stylish loft with rooftop access and city views', 200.00, 'San Francisco, CA'),
(4, 'Historic Townhouse', 'Charming historic property in the old town district', 150.00, 'Boston, MA');

-- Insert Bookings
INSERT INTO bookings (user_id, listing_id, start_date, end_date, total_price) VALUES
(2, 1, '2024-01-15', '2024-01-18', 360.00),
(3, 2, '2024-02-10', '2024-02-14', 1000.00),
(4, 3, '2024-03-05', '2024-03-08', 540.00),
(5, 4, '2024-04-20', '2024-04-23', 600.00),
(2, 5, '2024-05-12', '2024-05-15', 450.00),
(1, 2, '2024-06-01', '2024-06-05', 1000.00),
(3, 1, '2024-07-08', '2024-07-11', 360.00),
(4, 4, '2024-08-15', '2024-08-18', 600.00);

-- Insert Reviews
INSERT INTO reviews (booking_id, rating, comment) VALUES
(1, 5, 'Amazing apartment! Clean, comfortable, and perfectly located. Would definitely stay again.'),
(2, 4, 'Beautiful beach house with stunning views. Only minor issue was the Wi-Fi connectivity.'),
(3, 5, 'Perfect mountain getaway. The cabin was cozy and the location was ideal for hiking.'),
(4, 3, 'Good location but the loft could use some maintenance. Overall decent stay.'),
(5, 4, 'Loved the historic charm of this townhouse. Great neighborhood for walking around.'),
(6, 5, 'Excellent beach house experience! Host was very responsive and accommodating.'),
(7, 4, 'Nice downtown apartment, very convenient for business travel. Slightly noisy at night.'),
(8, 5, 'Outstanding city loft with incredible rooftop views. Highly recommend for special occasions.');
