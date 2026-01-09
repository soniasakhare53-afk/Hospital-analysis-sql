INSERT INTO patients (patient_name, gender, date_of_birth, city, phone, created_at)
SELECT
  CONCAT('Patient_', FLOOR(RAND()*10000)),
  ELT(FLOOR(1 + RAND()*3), 'Male','Female','Other'),
  DATE_SUB(CURDATE(), INTERVAL FLOOR(20 + RAND()*40) YEAR),
  ELT(FLOOR(1 + RAND()*5), 'Mumbai','Delhi','Pune','Chennai','Bangalore'),
  CONCAT('98', FLOOR(10000000 + RAND()*89999999)),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*150) DAY)
FROM information_schema.tables
LIMIT 30;


INSERT INTO doctors (doctor_name, specialization, department, consultation_fee)
SELECT
  CONCAT('Dr_', FLOOR(RAND()*1000)),
  ELT(FLOOR(1 + RAND()*5), 'Cardiology','Orthopedics','Neurology','Dermatology','General'),
  ELT(FLOOR(1 + RAND()*5), 'Heart','Bones','Brain','Skin','General'),
  FLOOR(400 + RAND()*700)
FROM information_schema.tables
LIMIT 8;


INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
SELECT
  FLOOR(1 + RAND() * (SELECT MAX(patient_id) FROM patients)),
  FLOOR(1 + RAND() * (SELECT MAX(doctor_id) FROM doctors)),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*180) DAY),
  ELT(FLOOR(1 + RAND()*3), 'Completed','Scheduled','Cancelled')
FROM information_schema.tables
LIMIT 120;


INSERT INTO admissions (patient_id, doctor_id, admission_date, discharge_date, room_type)
SELECT
  FLOOR(1 + RAND() * (SELECT MAX(patient_id) FROM patients)),
  FLOOR(1 + RAND() * (SELECT MAX(doctor_id) FROM doctors)),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*150) DAY),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(3 + RAND()*10) DAY),
  ELT(FLOOR(1 + RAND()*3), 'General','Private','ICU')
FROM information_schema.tables
LIMIT 40;


INSERT INTO treatments (admission_id, treatment_name, treatment_cost)
SELECT
  FLOOR(1 + RAND() * (SELECT MAX(admission_id) FROM admissions)),
  ELT(FLOOR(1 + RAND()*5), 'X-Ray','MRI','Surgery','Medication','Physiotherapy'),
  FLOOR(3000 + RAND()*40000)
FROM information_schema.tables
LIMIT 80;


INSERT INTO bills (admission_id, total_amount, bill_date, payment_status)
SELECT
  admission_id,
  FLOOR(8000 + RAND()*90000),
  DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*180) DAY),
  ELT(FLOOR(1 + RAND()*3), 'Paid','Unpaid','Partial')
FROM admissions
LIMIT 40;


INSERT INTO payments (bill_id, payment_date, amount_paid, payment_method)
SELECT
  bill_id,
  bill_date,
  FLOOR(total_amount * (0.5 + RAND()*0.5)),
  ELT(FLOOR(1 + RAND()*4), 'Cash','Card','UPI','Insurance')
FROM bills
WHERE payment_status != 'Unpaid'
LIMIT 35;
