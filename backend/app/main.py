from fastapi import FastAPI

from app.api.routes import auth

app = FastAPI(title="SmartMed API")

app.include_router(auth.router)


@app.get("/")
def accueil():
    return {"message": "Bienvenue dans SmartMed !"}