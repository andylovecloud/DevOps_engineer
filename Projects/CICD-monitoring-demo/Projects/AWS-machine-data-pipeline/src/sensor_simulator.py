import json, random, time, requests, datetime

API_URL = "https://69ktd4g3c2.execute-api.eu-north-1.amazonaws.com/dev/upload"  # thay URL của bạn

def gen():
    return {
        "machine_id": f"M-{random.randint(1,3)}",
        "temperature": round(random.uniform(20, 95), 2),
        "vibration": round(random.uniform(0.05, 2.5), 2),
        "timestamp": datetime.datetime.utcnow().isoformat()
    }

if __name__ == "__main__":
    while True:
        payload = gen()
        r = requests.post(API_URL, json=payload, timeout=10)
        print(r.status_code, payload)
        time.sleep(5)
