Sistema web Full Stack para reservar turnos médicos online. Proyecto Final Integrador de Prácticas
Profesionalizantes 2 (Tecnicatura Superior en Programación, ciclo 2026).
**Equipo:** Andie Eileen Cruz (Líder / Scrum Master) · Abigail Aramayo (Backend) · Fernando Aramayo
(Backend) · Florencia Vivas (Frontend)
## Tecnologías
| Capa | Tecnología |
|------|-----------|
| Base de datos | PostgreSQL 14+ |
| Backend | Python, FastAPI, SQLAlchemy, Pydantic, JWT + bcrypt |
| Frontend | React 18, Vite 5, React Router v6, axios, CSS3 |
## Estructura
```
backend/ API REST (FastAPI + SQLAlchemy + PostgreSQL)
frontend/ Aplicación web (React + Vite)
docs/ Requerimientos, historias de usuario, DER, informes de sprint
```
## Instalación
### 1. Base de datos
1. Crear la base `turnos_db` en PostgreSQL (pgAdmin).
2. Ejecutar `backend/schema.sql` y después `backend/seed.sql` (Query Tool de pgAdmin).
### 2. Backend
```powershell
cd backend
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
copy .env.example .env # completar DATABASE_URL con tu contraseña
uvicorn app.main:app --reload
```
API en http://localhost:8000 · Documentación (Swagger) en http://localhost:8000/docs
### 3. Frontend
```powershell
cd frontend
npm install
copy .env.example .env
npm run dev
```
Aplicación en http://localhost:5173
## Pruebas del backend
```powershell
cd backend
pytest
```
## Estado del proyecto
- [x] Semana 1: organización, repositorio y esqueleto
- [ ] Semana 2: requerimientos y wireframes
- [ ] Semana 3: DER y script SQL
- [ ] Semana 4: API con rutas básicas
- [ ] Semana 5: autenticación JWT y CRUD de turnos
- [ ] Semana 6 a 9: frontend, integración, pruebas y documentación
Turnos Médicos Online · 7
## Capturas de pantalla
_(se agregan en la Semana 9)_