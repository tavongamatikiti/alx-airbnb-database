# Database Normalization – Airbnb Clone

## Objective

To ensure our database schema is free from redundancy and anomalies by applying **Normalization up to Third Normal Form (3NF).**

---

## Step 1: First Normal Form (1NF)

**Rule:** Eliminate repeating groups; ensure atomic values.

- ✅ Each table has a **primary key**.
- ✅ All attributes are **atomic** (e.g., `phone_number` instead of a list of numbers).
- ✅ No multi-valued attributes or repeating columns.

**Example Fix:**

- Instead of storing multiple amenities in one column like:  
  `amenities = "wifi, parking, pool"`  
  → Create a separate **PropertyAmenities** table with one amenity per row.

---

## Step 2: Second Normal Form (2NF)

**Rule:** Eliminate partial dependency (no attribute should depend on part of a composite key).

- ✅ Every non-key attribute depends on the **whole primary key**.
- ✅ Removed any partial dependency.

**Example Fix:**

- If a `Booking` table had:  
  `(user_id, property_id)` as primary key and also included `user_email`,  
  → `user_email` depends only on `user_id`, not the full composite key.  
  → Solution: Move `user_email` to the **User** table.

---

## Step 3: Third Normal Form (3NF)

**Rule:** Eliminate transitive dependency (non-key attributes should not depend on other non-key attributes).

- ✅ Non-key attributes depend **only on the primary key**.
- ✅ Removed derived and indirectly dependent attributes.

**Example Fix:**

- If `Property` table had `city` and `zipcode`, and `zipcode` determines `city`,  
  → `city` is transitively dependent on `zipcode`.  
  → Solution: Create a separate **Location** table with (`zipcode`, `city`, `state`, `country`).

---

## Final Normalized Schema (3NF)

### **User**

- `user_id` (PK)
- `name`
- `email`
- `phone_number`

### **Property**

- `property_id` (PK)
- `user_id` (FK → User)
- `title`
- `description`
- `price_per_night`
- `location_id` (FK → Location)

### **Location**

- `location_id` (PK)
- `city`
- `state`
- `country`
- `zipcode`

### **Booking**

- `booking_id` (PK)
- `user_id` (FK → User)
- `property_id` (FK → Property)
- `check_in_date`
- `check_out_date`
- `total_price`

### **Review**

- `review_id` (PK)
- `booking_id` (FK → Booking)
- `rating`
- `comment`

### **PropertyAmenities**

- `property_id` (FK → Property)
- `amenity`

---

## ✅ Conclusion

The database schema now:

- Eliminates redundancy,
- Ensures atomic data,
- Prevents anomalies,
- Achieves **Third Normal Form (3NF)**.
