"""Trebuchet"""

import uvicorn
from fastapi import FastAPI

__version__ = "0.1.0"

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


uvicorn.run(app, host="0.0.0.0", port=8000, log_level="info")
