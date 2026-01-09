--Which doctors are handling the most appointments?
SELECT
  d.doctor_name,
  d.specialization,
  COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_name, d.specialization
ORDER BY total_appointments DESC;


-- How much revenue is generated each month?
SELECT
  DATE_FORMAT(b.bill_date, '%Y-%m') AS month,
  SUM(b.total_amount) AS total_revenue
FROM bills b
GROUP BY month
ORDER BY month;


-- Which room type has longer patient stays?
SELECT
  room_type,
  AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay_days
FROM admissions
WHERE discharge_date IS NOT NULL
GROUP BY room_type;


-- Which treatments bring the most money?
SELECT
  treatment_name,
  SUM(treatment_cost) AS total_revenue
FROM treatments
GROUP BY treatment_name
ORDER BY total_revenue DESC;


-- Identify repeat patients.
SELECT
  p.patient_name,
  COUNT(a.admission_id) AS admission_count
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
GROUP BY p.patient_name
HAVING admission_count > 1
ORDER BY admission_count DESC;


-- How much money is pending?
SELECT
  payment_status,
  COUNT(*) AS bill_count,
  SUM(total_amount) AS total_amount
FROM bills
WHERE payment_status IN ('Unpaid','Partial')
GROUP BY payment_status;
