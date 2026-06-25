from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from HF Docker Space!"}

@app.get("/greet/{name}")
def greet(name: str):
    return {"message": f"Hello {name}!!"}