from fastapi import FastAPI

app = FastAPI(title="SmartMed API")

@app.get("/")
def accueil():
    return {"message": "Bienvenue dans SmartMed !"}