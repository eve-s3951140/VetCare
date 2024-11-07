---------------- Create Tables ----------------
-- Clinic Address --
CREATE TABLE IF NOT EXISTS clinic_address (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	street VARCHAR(255) NOT NULL,
	suburb VARCHAR(50) NOT NULL,
	state VARCHAR(30) NOT NULL,
	postcode CHAR(4) NOT NULL 
);
INSERT INTO clinic_address VALUES 
(1, '1 Boundary Rd', 'North Melbourne', 'Victoria', '3051'),
(2, '109 Bay St', 'Port Melbourne', 'Victoria', '3207'),
(3, '210 Lygon St', 'Brunswick East', 'Victoria', '3055');

-- Clinic --
CREATE TABLE IF NOT EXISTS clinic (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	password TEXT NOT NULL,
	clinic_address_id INTEGER NOT NULL,
	FOREIGN KEY (clinic_address_id) REFERENCES clinic_address(id) ON DELETE CASCADE
);
INSERT INTO clinic VALUES 
(1, 'Frank Samways Veterinary Clinic', 'vetclinic@franksamsways.com', 'franksamwaysclinic', 1),
(2, 'Port Melbourne Veterinary Clinic', 'appointment@portmelbournevet.com', 'portmelbournevet', 2),
(3, 'Brunswick Central Vet Clinic', 'reception@brunswickcentralvet.com.au', 'brunswickcentralvet', 3);

-- User --
CREATE TABLE IF NOT EXISTS users(
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	birth_date DATE NOT NULL,
	gender VARCHAR(10) NOT NULL,
	phone_number CHAR(10) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	password TEXT NOT NULL
);
INSERT INTO users (first_name, last_name, birth_date, gender, phone_number, email, password) VALUES
('John', 'Johnny Jr.', '2005-02-10', 'Male', '0126741127', 'littlejohn@gmail.com', 'galvanisedSquareSteel(hashed)'), 
('Jude', 'Bellingham', '1980-12-10', 'Male', '0782937410', 'j_bellingham@gmail.com', 'unknownHollowFeathers(hashed)'), 
('Susan', 'Smith', '1990-01-17', 'Female', '0453297849', 'ssmith@yahoo.com', 'hashed'), 
('Sarah', 'Thompson', '1979-04-20', 'Female', '0295783902', 'thompsonS@yahoo.com', 'hashedpassword'),
('Jordan', 'Jackson', '1980-01-01', 'Male', '0109283905', 'jordanS@gmail.com', 'hashedpassword'),
('Jeremy', 'John', '1985-10-15', 'Male', '019278920', 'jeremyJ@gmail.com', 'hashedpassword');

-- Address --
CREATE TABLE IF NOT EXISTS "ADDRESS"(
	id INT AUTO_INCREMENT PRIMARY KEY,
	street VARCHAR(255) NOT NULL,
	suburb VARCHAR(50) NOT NULL,
	state VARCHAR(30) NOT NULL,
	postcode CHAR(4) NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
INSERT INTO address (street, suburb, state, postcode, user_id) VALUES
('1 Little John Court', 'Werribee', 'Victoria', '3030', 1), 
('19 Arras Parade', 'Ryde', 'New South Wales', '2112', 2), 
('2 Neath Street', 'Surrey Hills', 'Victoria', '3127', 3), 
('186 Strong Avenue', 'Graceville', 'Queensland', '4075', 4),
('196 Nice Avenue', 'Sydney', 'New South Wales', '3075', 5),
('1 Drive Street', 'Carlton', 'Victoria', '3053', 6);

-- Pet Owner --
CREATE TABLE IF NOT EXISTS pet_owner(
	id INT AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
INSERT INTO pet_owner (user_id) VALUES (1), (3);

-- Pet --
CREATE TABLE IF NOT EXISTS pet (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	birth_date DATE NOT NULL,
	species VARCHAR(255) NOT NULL,
	breed VARCHAR(255) NOT NULL,
	gender VARCHAR(6) NOT NULL,
	weight FLOAT NOT NULL,
    allergies VARCHAR(255),
    existing_conditions VARCHAR(255),
	pet_owner_id INTEGER NOT NULL,
	FOREIGN KEY (pet_owner_id) REFERENCES pet_owner(id) ON DELETE CASCADE
);
INSERT INTO pet (name, birth_date, species, breed, gender, weight, allergies, existing_conditions, pet_owner_id) VALUES 
('Rocky', '2024-05-31', 'Dog', 'Chihuahua', 'Male', 1.5, 'Dust', 'Arthritis',  1), 
('Luna', '2023-01-31', 'Dog', 'Chihuahua', 'Female', 2.1, 'Aloe Vera', 'Hip Dysplasia', 1), 
('Stella', '2023-01-31', 'Cat', 'Egyptian Mau', 'Female', 2.1, 'Pollens', 'Asthma', 2);

-- Immunisation History --
CREATE TABLE IF NOT EXISTS immunisation_history (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	notes VARCHAR(255),
	pet_id INTEGER NOT NULL,
	FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE CASCADE
);
INSERT INTO immunisation_history (name, date, notes, pet_id) VALUES 
('HPV', '2023-12-14', '', 1), 
('Bordatella', '2023-12-14', '', 1), 
('Rabies', '2024-01-17', '', 2), 
('Lyme', '2024-01-17', '', 2);

-- Surgery History --
CREATE TABLE IF NOT EXISTS surgery_history (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	notes VARCHAR(255),
	pet_id INTEGER NOT NULL,
	FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE CASCADE
);
INSERT INTO surgery_history (name, date, notes, pet_id) VALUES 
('Gastrointestinal Obstructions', '2023-12-14', 'No complications during surgery.', 1), 
('Hernia Repair', '2023-12-14', 'Laparoscopic procedure performed.', 2), 
('Gastropexy', '2024-01-16', 'Surgery to prevent future gastric dilatation.', 2), 
('ACL Repair Surgery', '2024-01-17', 'Patient advised on physiotherapy for recovery.', 2);

-- Vet --
CREATE TABLE IF NOT EXISTS vet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    languages_spoken VARCHAR(255) NOT NULL,
    self_description TEXT NOT NULL,
    user_id INT NOT NULL,
    clinic_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES clinic(id) ON DELETE CASCADE
);

INSERT INTO vet (title, languages_spoken, self_description, user_id, clinic_id) VALUES
('Dr.', 'English, Russian, Italian', 'Basic description for a vet... uh...??', 2, 1),
('Surgeon', 'English, Spanish', 'I have very steady hands and am skillful with knives in the operating room', 4, 2),
('Dr.', 'English, Italian', 'Jordan is an internationally recognized expert in animal neurophysiology and the diagnosis of neuromuscular disorders.', 5, 2),
('Dr.', 'English, Chinese, Malay', 'I am dedicated to providing comprehensive and compassionate care to pets of all ages, ensuring their overall well-being and health.', 6, 3);

-- Qualification --
CREATE TABLE IF NOT EXISTS qualification(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	university VARCHAR(255) NOT NULL,
	country VARCHAR(255) NOT NULL,
	years INT NOT NULL,
	vet_id INT NOT NULL,
	FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE CASCADE
);
INSERT INTO qualification (name, university, country, years, vet_id) VALUES 
('Bachelor of Veterinary Science (BVSc)', 'University of Melbourne', 'Australia', 1997, 1), 
('Master of Veterinary Science (MVSc)', 'University of Melbourne', 'Australia', 2002, 1),
('Bachelor of Veterinary Science (MVSc)', 'RMIT University', 'Australia', 1990, 2),
('Bachelor of Veterinary Science (MVSc)', 'University of Sdyney', 'Australia', 1998, 3),
('Master of Veterinary Science (MVSc)', 'University of New South Wales', 'Australia', 2003, 4);

-- Availability --
CREATE TABLE IF NOT EXISTS availability (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	date DATE NOT NULL,
	start_time TIME(0) NOT NULL,
	end_time TIME(0) NOT NULL
);

-- Vet Availability --
CREATE TABLE IF NOT EXISTS vet_availability (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  vet_id INTEGER NOT NULL,
  availability_id INTEGER NOT NULL,
  FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE CASCADE,
  FOREIGN KEY (availability_id) REFERENCES availability(id),
    CONSTRAINT unique_vet_availability UNIQUE (vet_id, availability_id)
);


-- Medicine --
CREATE TABLE IF NOT EXISTS medicine (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	quantity INTEGER NOT NULL,
    price DOUBLE NOT NULL
);
INSERT INTO medicine VALUES 
(1, 'Antinol Plus EAB-277 For Dogs', 1000, 1.5), 
(2, 'Vetmedin 1ss.25mg Flavoured Chewable Tablets For Dogs', 1500, 0.85), 
(3, 'Clomicalm 80mg Tablets For Dogs and Cats', 2000, 1.35);

-- Appointment Type --
CREATE TABLE IF NOT EXISTS appointment_type (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	duration INTEGER NOT NULL,
	description TEXT NOT NULL
);
INSERT INTO appointment_type VALUES 
(1, 'General Clinical Consultation', 30, 'This service involves a comprehensive assessment of your pet’s overall health. The veterinarian will discuss any concerns you have, review your pet’s medical history, and provide recommendations for preventive care or treatment.'), 
(2, 'Physical Examination', 45, 'During a physical examination, the veterinarian will thoroughly check your pet’s body, including the eyes, ears, mouth, skin, and coat. This helps in identifying any signs of illness or abnormalities early on.'), 
(3, 'Dental Care', 30, 'Dental care services focus on maintaining your pet’s oral health. This includes teeth cleaning, polishing, and addressing any dental issues such as plaque buildup, gum disease, or tooth extractions if necessary.'), 
(4, 'Surgery', 90, 'Veterinary surgery encompasses a wide range of procedures, from routine spaying and neutering to more complex surgeries like tumor removal or orthopedic operations. These procedures are performed under anesthesia to ensure your pet’s comfort and safety.'), 
(5, 'Diet and Nutrition', 60, 'This service involves creating a balanced and nutritious diet plan tailored to your pet’s specific needs. The veterinarian will provide guidance on the best types of food, portion sizes, and any necessary supplements to ensure your pet’s optimal health.');

-- Clinic Appointment Type Price --
CREATE TABLE IF NOT EXISTS clinic_appointment_type_price (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
    clinic_id INT NOT NULL,
    appointment_type_id INT NOT NULL,
    price DOUBLE NOT NULL,
	FOREIGN KEY (clinic_id) REFERENCES clinic(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_type_id) REFERENCES appointment_type(id)
);
INSERT INTO clinic_appointment_type_price VALUES 
(1, 1, 1, 80.00), (2, 1, 2, 105.00), (3, 1, 3, 150.00), (4, 1, 4, 2500.00), (5, 1, 5, 70.00),
(6, 2, 1, 100.00), (7, 2, 2, 120.00), (8, 2, 3, 130.00), (9, 2, 4, 3000.00), (10, 2, 5, 75.00),
(11, 3, 1, 90.00), (12, 3, 2, 130.00), (13, 3, 3, 125.00), (14, 3, 4, 2750.00), (15, 3, 5, 65.00);

-- Appointment --
CREATE TABLE IF NOT EXISTS appointment (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	date DATE NOT NULL,
	start_time TIME(0) NOT NULL,
	end_time TIME(0) NOT NULL,
	vet_id INTEGER NOT NULL,
	pet_id INTEGER NOT NULL,
	appointment_type_id INTEGER NOT NULL,
	FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE CASCADE,
	FOREIGN KEY (pet_id) REFERENCES pet(id) ON DELETE CASCADE,
	FOREIGN KEY (appointment_type_id) REFERENCES appointment_type(id)
);
INSERT INTO appointment (date, start_time, end_time, vet_id, pet_id, appointment_type_id) VALUES
('2024-11-01', '13:00', '13:30', 1, 1, 1),
('2024-11-02', '10:00', '11:30', 1, 2, 2),
('2024-11-01', '15:00', '14:00', 1, 1, 1);

-- Vet Appointment Type Offered --
CREATE TABLE IF NOT EXISTS vet_appointment_type_offered(
	id INT AUTO_INCREMENT PRIMARY KEY,
    vet_id INTEGER NOT NULL,
    appointment_type_id INTEGER NOT NULL,
    FOREIGN KEY (vet_id) REFERENCES vet(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_type_id) REFERENCES appointment_type(id) ON DELETE CASCADE
);
INSERT INTO vet_appointment_type_offered VALUES (1, 1, 1), (2,1,2), (3,1,3), (4,1,5), (5,2,1), (6,2,3), (7,2,4), (8,2,5), (9, 3, 1), (10, 3, 3), (11, 3, 4), (12, 3, 5), (13, 4, 1), (14, 4, 2), (15, 4, 3), (16, 4, 5);

-- Order --
CREATE TABLE IF NOT EXISTS orders (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	date DATE NOT NULL,
	status VARCHAR(255) NOT NULL
);
INSERT INTO orders (date, status) VALUES 
('2024-09-01', 'Delivered'), 
('2024-09-02', 'Waiting for pickup'), 
('2024-09-03', 'Packing order');

-- Prescribed Medication --
CREATE TABLE IF NOT EXISTS prescribed_medication (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	dosage INTEGER NOT NULL,
	daily_frequency INTEGER NOT NULL,
	duration INTEGER NOT NULL,
	instruction TEXT NOT NULL,
	medicine_id INTEGER NOT NULL,
	order_id INTEGER NOT NULL, 
	appointment_id INTEGER NOT NULL,
	FOREIGN KEY (medicine_id) REFERENCES medicine(id),
	FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
	FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE CASCADE
);
INSERT INTO prescribed_medication (dosage, daily_frequency, duration, instruction, medicine_id, order_id, appointment_id) VALUES 
(1, 3, 14, 'Feed during breakfast, lunch and dinner', 1, 2, 1), 
(1, 2, 11, 'Swallow the pill along water. Feed during breakfast, and dinner', 2, 1, 1), 
(1, 2, 14, 'Swallow the pill along food. Feed during breakfast, and dinner', 2, 1, 2);