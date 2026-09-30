"""Punto de entrada de la API de Turnos Medicos."""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import CORS_ORIGINS

app = FastAPI(
    title="Turnos Medicos Online - API",
    description="API REST para gestionar especialidades, medicos y turnos.",
    version="0.1.0",
)
# CORS: permite que el frontend (React) pueda hacerle pedidos a esta API.
app.add_middleware(
    CORSMiddleware,
    allow_origins=CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/api/health", tags=["Estado"])
def health():
    """Sirve para comprobar que la API esta viva."""
    return {"status": "ok"}