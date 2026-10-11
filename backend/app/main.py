from fastapi import FastAPI

from app.api.routes import auth, users

app = FastAPI(title="SmartMed API")

app.include_router(auth.router)
app.include_router(users.router)


@app.get("/")
def accueil():
    return {"message": "Bienvenue dans SmartMed !"}