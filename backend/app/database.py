"""Conexion a PostgreSQL con SQLAlchemy."""
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, sessionmaker
from app.config import DATABASE_URL
engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)

class Base(DeclarativeBase):
    """Clase base de la que heredan todos los modelos."""
    pass
def get_db():
    """Dependencia de FastAPI: abre una sesion por request y la cierra al terminar."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()