# Task 0: Define Entities and Relationships in ER Diagram

## Objective

Design an Entity-Relationship (ER) diagram for the **Airbnb-like database**.  
The goal is to identify the core entities, their attributes, and the relationships between them.

---

## Entities and Attributes

### 1. User

- **id** (Primary Key)
- first_name
- last_name
- email
- phone_number
- password
- created_at
- updated_at

### 2. Property

- **id** (Primary Key)
- owner_id (Foreign Key → User.id)
- title
- description
- address
- city
- country
- price_per_night
- created_at
- updated_at

### 3. Booking

- **id** (Primary Key)
- user_id (Foreign Key → User.id)
- property_id (Foreign Key → Property.id)
- start_date
- end_date
- total_price
- status (pending, confirmed, cancelled)
- created_at
- updated_at

### 4. Review

- **id** (Primary Key)
- user_id (Foreign Key → User.id)
- property_id (Foreign Key → Property.id)
- rating (1–5)
- comment
- created_at

### 5. Payment

- **id** (Primary Key)
- booking_id (Foreign Key → Booking.id)
- amount
- payment_date
- method (card, mobile money, PayPal, etc.)
- status (pending, completed, failed)

---

## Relationships

1. **User → Booking**:  
   A user can make many bookings. Each booking belongs to exactly one user.  
   _(One-to-Many)_

2. **User → Property**:  
   A user (host) can own many properties. Each property belongs to exactly one user.  
   _(One-to-Many)_

3. **Property → Booking**:  
   A property can be booked many times. Each booking refers to one property.  
   _(One-to-Many)_

4. **User → Review**:  
   A user can write many reviews. Each review is linked to one user.  
   _(One-to-Many)_

5. **Property → Review**:  
   A property can have many reviews. Each review is linked to one property.  
   _(One-to-Many)_

6. **Booking → Payment**:  
   Each booking can have one payment. A payment belongs to exactly one booking.  
   _(One-to-One)_

---

## ER Diagram

The visual ER diagram can be found in this directory:

📄 `ERD/airbnb_er_diagram.png`

---

## Notes

- All primary keys are unique identifiers (`id`) for each entity.
- Foreign keys are used to define relationships.
- Timestamps (`created_at`, `updated_at`) help track changes.
- The design follows normalization up to **3NF** to reduce redundancy.
