from fastapi import FastAPI
from mangum import Mangum

app = FastAPI(title="CI/CD Monitoring Demo")

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/sum")
def sum_(a: int, b: int):
    return {"result": a + b}

# Lambda handler
handler = Mangum(app)