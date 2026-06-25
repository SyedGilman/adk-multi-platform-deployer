from fastapi import FastAPI
from app.agent import GoogleADKAgent
import uvicorn
app = FastAPI()
agent = GoogleADKAgent()
@app.on_event("startup")
def startup(): agent.initialize_agent()
@app.get("/")
def root(): return {"status": "healthy"}
@app.get("/predict")
def predict(prompt: str = "Hello"): return {"response": agent.run_inference(prompt)}
