-- ZOMATO PROJECT - RESTAURANTS TABLE

DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id   SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    city            VARCHAR(50) NOT NULL,
    opening_hours   VARCHAR(30) NOT NULL
);

INSERT INTO restaurants (restaurant_id, restaurant_name, city, opening_hours) VALUES
    (1, 'Tandoor Rooftop Adda', 'Nashik', '07:00 AM - 10:00 PM'),
    (2, 'Delhi Point', 'Kanpur', '12:00 PM - 11:00 PM'),
    (3, 'Heritage Chinese Junction', 'Kolkata', '07:00 AM - 10:00 PM'),
    (4, 'Desi Mahal', 'Amritsar', '07:00 AM - 10:00 PM'),
    (5, 'Regal Chinese Bites', 'Mumbai', '24 Hours'),
    (6, 'Desi Family Garden', 'Mumbai', '06:00 AM - 10:00 PM'),
    (7, 'Tandoor Mughlai Kitchen', 'Nagpur', '08:00 AM - 12:00 AM'),
    (8, 'Masala Street Point', 'Mumbai', '08:00 AM - 11:00 PM'),
    (9, 'Masala Punjabi Delight', 'Madurai', '09:00 AM - 12:00 AM'),
    (10, 'Tandoor Family Corner', 'Amritsar', '07:00 AM - 11:00 PM'),
    (11, 'Royal Village Mahal', 'Coimbatore', '09:00 AM - 12:00 AM'),
    (12, 'Delhi Punjabi Mahal', 'Agra', '08:00 AM - 10:00 PM'),
    (13, 'Saffron Rasoi', 'Jaipur', '08:00 AM - 10:00 PM'),
    (14, 'Tandoor Family Point', 'Kanpur', '24 Hours'),
    (15, 'Nawab Rooftop Bhavan', 'Bengaluru', '12:00 PM - 11:00 PM'),
    (16, 'Paradise Punjabi Rasoi', 'Amritsar', '24 Hours'),
    (17, 'Anand Rooftop Hub', 'Hyderabad', '12:00 PM - 11:00 PM'),
    (18, 'Delhi Mughlai Bhavan', 'Delhi', '24 Hours'),
    (19, 'Regal Classic Rasoi', 'Rajkot', '09:00 AM - 12:00 AM'),
    (20, 'Bombay Punjabi Kitchen', 'Patna', '07:30 AM - 11:00 PM'),
    (21, 'Anand Rooftop Express', 'Lucknow', '08:00 AM - 10:00 PM'),
    (22, 'Golden Mahal', 'Agra', '08:00 AM - 10:00 PM'),
    (23, 'Haveli Indian Garden', 'Coimbatore', '07:30 AM - 11:00 PM'),
    (24, 'Punjabi Village Rasoi', 'Ludhiana', '07:30 AM - 11:00 PM'),
    (25, 'Punjabi Palace', 'Faridabad', '08:00 AM - 12:00 AM'),
    (26, 'Nawab Classic Mahal', 'Surat', '12:00 PM - 11:00 PM'),
    (27, 'Nawab Corner', 'Ludhiana', '08:00 AM - 10:00 PM'),
    (28, 'Biryani Family Mahal', 'Jaipur', '09:00 AM - 11:00 PM'),
    (29, 'Tandoor Rasoi', 'Madurai', '09:00 AM - 11:00 PM'),
    (30, 'Masala Mughlai Mahal', 'Amritsar', '11:00 AM - 11:00 PM'),
    (31, 'Heritage Hub', 'Visakhapatnam', '12:00 PM - 11:00 PM'),
    (32, 'Honest Rooftop Delight', 'Lucknow', '07:00 AM - 10:00 PM'),
    (33, 'Masala Street Junction', 'Jaipur', '06:00 AM - 10:00 PM'),
    (34, 'Nawab Flavours', 'Pune', '07:30 AM - 11:00 PM'),
    (35, 'Desi Treats', 'Vadodara', '09:00 AM - 12:00 AM'),
    (36, 'Kabab Chinese Adda', 'Chennai', '10:00 AM - 11:00 PM'),
    (37, 'Shahi Village Kitchen', 'Patna', '12:00 PM - 11:00 PM'),
    (38, 'Bombay Express', 'Hyderabad', '09:00 AM - 11:00 PM'),
    (39, 'Nawab Bites', 'Meerut', '07:00 AM - 11:00 PM'),
    (40, 'Regal Rooftop Palace', 'Varanasi', '07:00 AM - 11:00 PM'),
    (41, 'Masala Rasoi', 'Bengaluru', '12:00 PM - 11:00 PM'),
    (42, 'Masala Bhavan', 'Vadodara', '10:00 AM - 11:00 PM'),
    (43, 'Kabab South Indian Garden', 'Amritsar', '11:00 AM - 10:00 PM'),
    (44, 'Honest South Indian Adda', 'Hyderabad', '11:00 AM - 11:00 PM'),
    (45, 'Delhi Indian Point', 'Nashik', '08:00 AM - 11:00 PM'),
    (46, 'Regal Bites', 'Madurai', '24 Hours'),
    (47, 'Bombay Village Express', 'Amritsar', '11:00 AM - 11:00 PM'),
    (48, 'Golden Rasoi', 'Visakhapatnam', '08:00 AM - 11:00 PM'),
    (49, 'Masala Village Tadka', 'Patna', '08:00 AM - 10:00 PM'),
    (50, 'Bombay Tadka', 'Delhi', '10:00 AM - 11:00 PM');

-- Verify
SELECT * FROM restaurants;