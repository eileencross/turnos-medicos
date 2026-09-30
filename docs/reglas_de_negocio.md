# Reglas de negocio - Turnos Médicos

| ID | Regla | Dónde se aplica |
|----|-------|-----------------|
| RN-01 | Cada médico pertenece a una sola especialidad. | FK doctors.specialty_id |
| RN-02 | Un médico tiene como máximo UN horario de atención por día de la semana (0 = lunes ... 6 = domingo). | UNIQUE (doctor_id, day_of_week) |
| RN-03 | La hora de fin de un horario debe ser posterior a la de inicio y la duración del turno debe ser mayor a 0. | CHECK en la BD y validación Pydantic |
| RN-04 | Los horarios disponibles se generan dividiendo el rango de atención en bloques de slot_duration minutos. Un bloque incompleto al final se descarta. | app/services/slots.py |
| RN-05 | No se ofrecen horarios ya reservados ni horarios que ya pasaron (si la fecha es hoy). | app/services/slots.py |
| RN-06 | No puede haber dos turnos confirmed para el mismo médico, fecha y hora (doble reserva). Los turnos cancelados no cuentan. | Índice único parcial uq_doctor_slot_confirmed |
| RN-07 | Estados válidos de un turno: confirmed, cancelled, completed. | CHECK en la BD |
| RN-08 | No se puede cancelar ni reprogramar un turno que ya pasó ni uno ya cancelado. | Backend (Semana 5) |
| RN-09 | Al cancelar se guarda la fecha (cancelled_at) y el motivo. El horario queda libre. | Backend (Semana 5) |
| RN-10 | Los médicos no se borran: se dan de baja con is_active = false, para conservar el historial de turnos. | FK ON DELETE RESTRICT |
| RN-11 | Un paciente solo ve y modifica sus propios turnos. | Backend (Semana 5) |
| RN-12 | Solo el personal (is_staff = true) accede al panel y a la gestión de médicos, horarios y especialidades. | Backend (Semana 5) |
| RN-13 | El email de usuario es único. | UNIQUE en users.email |