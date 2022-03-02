
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE (id),
  name VARCHAR NOT NULL,
  date_of_birth DATE NOT NULL
);

CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE (id),
  type VARCHAR NOT NULL,
  name VARCHAR NOT NULL
);

CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP NOT NULL,
  patient_id BIGINT REFERENCES patients(id),
  treatment_id BIGINT REFERENCES treatments(id),
  status VARCHAR NOT NULL,
  CONSTRAINT fk_patient_id FOREIGN KEY(patient_id) REFERENCES patients(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  UNIQUE (patient_id),
  UNIQUE (treatment_id)
);

CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  UNIQUE(id),
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL,
  payed_at TIMESTAMP NOT NULL,
  fk_medical_history_id BIGINT NOT NULL,
  CONSTRAINT fk_medical_history_id FOREIGN KEY (fk_medical_history_id) REFERENCES medical_histories (patient_id),
  UNIQUE(fk_medical_history_id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY(treatment_id) REFERENCES treatments(id),
  UNIQUE(invoice_id, treatment_id)
);


