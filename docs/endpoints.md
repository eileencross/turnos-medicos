# Lista de Endpoints de la API
Base URL local: http://localhost:8000
Documentación interactiva: /docs

Leyenda de estado:
- [S1/S4/S5]: Semana en la que se implementa

## Estado del servicio
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| GET | /api/health | Probar que la API funcione | Público | S1 |

## Especialidades
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| GET | /api/specialties | Lista todas las especialidades | Público | S4 |
| GET | /api/specialties/{id} | Detalle de una especialidad | Público | S4 |
| POST | /api/specialties | Crea una especialidad | Personal | S4 (sin proteger) |
| PUT | /api/specialties/{id} | Edita una especialidad | Personal | S5 |

## Médicos y Horarios
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| GET | /api/doctors?specialty_id=&search= | Lista médicos activos con filtros | Público | S4 |
| GET | /api/doctors/{id} | Detalle de un médico | Público | S4 |
| POST | /api/doctors | Crea un médico | Personal | S4 (sin proteger) |
| PUT | /api/doctors/{id} | Edita un médico | Personal | S5 |
| DELETE | /api/doctors/{id} |Dar de baja a un medico(is_active = false) | Personal | S5 |
| GET | /api/doctors/{id}/schedules | Horarios de atención del médico | Público | S4 |
| POST | /api/doctors/{id}/schedules | Agrega un horario de atención | Personal | S4 (sin proteger) |
| GET | /api/doctors/{id}/available-slots?date=AAAA-MM-DD | Horarios libres para una fecha | Público | S4 |

## Autenticación y Perfil
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| POST | /api/auth/register | Registro de paciente | Público | S5 |
| POST | /api/auth/login | Login, devuelve token JWT | Público | S5 |
| GET | /api/auth/me | Datos del usuario logueado | Autenticado | S5 |
| PUT | /api/auth/me | Edita datos y perfil | Autenticado | S5 |

## Turnos
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| POST | /api/appointments | Reserva un turno | Paciente | S5 |
| GET | /api/appointments/mine | Mis turnos | Paciente | S5 |
| PATCH | /api/appointments/{id}/cancel | Cancela un turno futuro | Paciente | S5 |
| PATCH | /api/appointments/{id}/reschedule | Reprograma un turno futuro | Paciente | S5 |
| PATCH | /api/appointments/{id}/complete | Marca un turno como completado | Personal | S5 |

## Panel de Administración
| Método | Ruta | Descripción | Acceso | Estado |
|---|---|---|---|---|
| GET | /api/admin/dashboard | Turnos del día, próximos y contadores | Personal | S5 |

## Códigos de respuesta estándar
- 200 OK | 201 Creado | 400 Pedido inválido | 401 No autenticado | 403 Sin permiso
- 404 No encontrado | 409 Conflicto (duplicado/doble reserva) | 422 Datos inválidos (Pydantic)