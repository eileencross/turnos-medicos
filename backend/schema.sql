-- =====================================================================
-- schema.sql - Turnos Medicos Online (PostgreSQL 14+)
-- Crea las 6 tablas del sistema. Se puede correr las veces que haga falta:
-- al principio borra las tablas si existen (SOLO PARA DESARROLLO).
-- =====================================================================
DROP TABLE IF EXISTS appointments CASCADE;
DROP TABLE IF EXISTS patient_profiles CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS doctor_schedules CASCADE;
DROP TABLE IF EXISTS doctors CASCADE;
DROP TABLE IF EXISTS specialties CASCADE;

-- 1) Especialidades medicas ---------------------------------------------
CREATE TABLE specialties (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NOT NULL DEFAULT '',
    icon VARCHAR(60) NOT NULL DEFAULT 'fa-stethoscope'
);

-- 2) Medicos (cada uno pertenece a UNA especialidad) ----------------------
CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    specialty_id INTEGER NOT NULL REFERENCES specialties(id) ON DELETE RESTRICT,
    bio TEXT NOT NULL DEFAULT '',
    phone VARCHAR(20) NOT NULL DEFAULT '',
    email VARCHAR(255) NOT NULL DEFAULT '',
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- 3) Horarios de atencion: un rango por medico y por dia de la semana ----
CREATE TABLE doctor_schedules (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER NOT NULL REFERENCES doctors(id) ON DELETE CASCADE,
    day_of_week INTEGER NOT NULL, -- 0 = Lunes ... 6 = Domingo
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_duration INTEGER NOT NULL DEFAULT 30, -- minutos por turno
    CONSTRAINT uq_doctor_day UNIQUE (doctor_id, day_of_week),
    CONSTRAINT ck_schedule_day CHECK (day_of_week BETWEEN 0 AND 6),
    CONSTRAINT ck_schedule_range CHECK (end_time > start_time),
    CONSTRAINT ck_schedule_slot CHECK (slot_duration > 0)
);

-- 4) Usuarios (pacientes y personal del consultorio) ----------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    first_name VARCHAR(150) NOT NULL DEFAULT '',
    last_name VARCHAR(150) NOT NULL DEFAULT '',
    is_staff BOOLEAN NOT NULL DEFAULT FALSE, -- TRUE = personal / admin
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- 5) Perfil del paciente (relacion 1 a 1 con users) -----------------------
CREATE TABLE patient_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    phone VARCHAR(20) NOT NULL DEFAULT '',
    dni VARCHAR(15) NOT NULL DEFAULT '',
    date_of_birth DATE,
    address VARCHAR(200) NOT NULL DEFAULT ''
);

-- 6) Turnos ---------------------------------------------------------------
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    doctor_id INTEGER NOT NULL REFERENCES doctors(id) ON DELETE RESTRICT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'confirmed',
    notes TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cancelled_at TIMESTAMP,
    cancellation_reason TEXT NOT NULL DEFAULT '',
    CONSTRAINT ck_appointment_status 
        CHECK (status IN ('confirmed', 'cancelled', 'completed'))
);

-- Evita la DOBLE RESERVA: solo puede haber UN turno "confirmed" por
-- medico + fecha + hora. Los cancelados no cuentan, asi el horario se libera.
CREATE UNIQUE INDEX uq_doctor_slot_confirmed
ON appointments (doctor_id, date, time)
WHERE status = 'confirmed';

-- Indices para acelerar las consultas mas comunes
CREATE INDEX ix_appointments_patient ON appointments (patient_id);
CREATE INDEX ix_appointments_date ON appointments (date);
CREATE INDEX ix_doctors_specialty ON doctors (specialty_id);