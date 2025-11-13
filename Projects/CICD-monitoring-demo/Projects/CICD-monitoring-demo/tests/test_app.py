from fastapi.testclient import TestClient
from app import app

def test_health():
    c = TestClient(app)
    r = c.get("/health")
    assert r.status_code == 200
    assert r.json()["status"] == "ok"

def test_sum():
    c = TestClient(app)
    r = c.get("/sum?a=2&b=5")
    assert r.status_code == 200
    assert r.json()["result"] == 7