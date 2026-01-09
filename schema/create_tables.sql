CREATE TABLE patients (
    patient_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    city VARCHAR(50),
    phone VARCHAR(15),
    created_at DATE
) ENGINE=InnoDB;


CREATE TABLE doctors (
    doctor_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    department VARCHAR(50),
    consultation_fee DECIMAL(10,2)
) ENGINE=InnoDB;


CREATE TABLE appointments (
    appointment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_id INT UNSIGNED,
    doctor_id INT UNSIGNED,
    appointment_date DATETIME,
    status ENUM('Scheduled','Completed','Cancelled'),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL
) ENGINE=InnoDB;


CREATE TABLE admissions (
    admission_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_id INT UNSIGNED,
    doctor_id INT UNSIGNED,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    room_type VARCHAR(30),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE SET NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE SET NULL
) ENGINE=InnoDB;


CREATE TABLE treatments (
    treatment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admission_id INT UNSIGNED,
    treatment_name VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE bills (
    bill_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    admission_id INT UNSIGNED,
    total_amount DECIMAL(10,2),
    bill_date DATE,
    payment_status ENUM('Paid','Unpaid','Partial'),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    bill_id INT UNSIGNED,
    payment_date DATE,
    amount_paid DECIMAL(10,2),
    payment_method ENUM('Cash','Card','UPI','Insurance'),
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE
) ENGINE=InnoDB;
