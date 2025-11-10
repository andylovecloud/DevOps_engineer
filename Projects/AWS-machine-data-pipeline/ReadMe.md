# 🏗️ AWS Machine Data Pipeline (Serverless IoT Demo)

This project simulates a real-world **industrial IoT data pipeline** using AWS serverless services.  
It ingests simulated machine telemetry data via an API, processes it using AWS Lambda, stores it in S3, and queries it using AWS Glue + Athena.

---

## 📚 Table of Contents

1. [Architecture & Purpose](#architecture--purpose)
2. [Prerequisites](#prerequisites)
3. [Setup Variables](#setup-variables)
4. [Step 1 – Create S3 Data Lake](#step-1--create-s3-data-lake)
5. [Step 2 – Create Lambda Execution Role (IAM)](#step-2--create-lambda-execution-role-iam)
6. [Step 3 – Create Lambda Function](#step-3--create-lambda-function)
7. [Step 4 – Create API Gateway (HTTP API)](#step-4--create-api-gateway-http-api)
8. [Step 5 – Run Local Sensor Simulator](#step-5--run-local-sensor-simulator)
9. [Step 6 – Create Glue Database & Crawler](#step-6--create-glue-database--crawler)
10. [Step 7 – Query in Athena](#step-7--query-in-athena)
11. [Step 8 – (Optional) Streamlit Dashboard](#step-8--optional-streamlit-dashboard)
12. [Troubleshooting](#troubleshooting)
13. [Cleanup](#cleanup)
14. [Screenshots to Capture](#screenshots-to-capture)

---

## ⚙️ Architecture & Purpose
Python Sensor Simulator
| (HTTPS JSON)
v
Amazon API Gateway (HTTP API)
v
AWS Lambda (process_iot_data)
v
Amazon S3 (Data Lake: raw JSON, partitioned by day/machine)
v
AWS Glue Crawler (schema discovery)
v
Amazon Athena (SQL analytics)
v
(Optional) Streamlit Dashboard



| Service | Role |
|----------|------|
| **Amazon API Gateway** | Secure HTTP endpoint for receiving sensor JSON data. |
| **AWS Lambda** | Processes and validates incoming data, stores it in S3. |
| **Amazon S3** | Data lake for raw machine telemetry, partitioned by day/machine. |
| **AWS Glue** | Automatically detects schema and registers the table for Athena. |
| **Amazon Athena** | Query data in S3 using SQL. |
| **Streamlit (Optional)** | Visualize live sensor data in a dashboard. |

---

## 🧩 Prerequisites

- AWS Account (Free Tier is fine)
- Python **3.10+**
- AWS CLI configured with valid credentials:
  ```bash
  aws configure
  # Access Key, Secret, Region (eu-north-1), Output: json


🧱 Setup Variables
| Variable        | Description      | Example                    |
| --------------- | ---------------- | -------------------------- |
| **Region**      | AWS Region       | `eu-north-1`               |
| **S3 Bucket**   | Data lake bucket | `kc-machine-data-yourname` |
| **Lambda Name** | Function name    | `process_iot_data`         |
| **Glue DB**     | Glue Database    | `machine_data_db`          |
| **API Stage**   | Gateway stage    | `dev`                      |


🪣 Step 1 – Create S3 Data Lake
1. Go to **AWS Console → S3 → Create bucket**
2. Bucket name: **kc-machine-data-yourname**
3. Region: your region (e.g., eu-north-1)
4. Leave “Block all public access” **ON**

Click Create bucket

👤 Step 2 – Create Lambda Execution Role (IAM)

1. Go to **IAM → Roles → Create role**
2. Trusted entity: **Lambda**
3. Attach policies:
 - **AmazonS3FullAccess**
 - **CloudWatchLogsFullAccess**
4. Name: **lambda_s3_writer_role**
5. Click **Create role**
   
🧠 Step 3 – Create Lambda Function

1. Go to **Lambda → Create function**
- Name: **process_iot_data**
- Runtime: **Python 3.12**
- Role: choose **lambda_s3_writer_role**

2. Add environment variable:
- Key: **<BUCKET_NAME>**
- Value: **kc-machine-data-<yourname>**

3. Replace default code with:

import json
import os
import boto3
from datetime import datetime, UTC
import base64

s3 = boto3.client("s3")
BUCKET = os.environ["BUCKET_NAME"]

def _get_body(event):
    if isinstance(event, dict) and "body" in event and event["body"] is not None:
        body_raw = event["body"]
        if event.get("isBase64Encoded"):
            body_raw = base64.b64decode(body_raw).decode("utf-8")
        return json.loads(body_raw)
    return event if isinstance(event, dict) else {}

def lambda_handler(event, context):
    body = _get_body(event)
    required = ["machine_id", "temperature", "vibration", "timestamp"]
    missing = [k for k in required if k not in body]
    if missing:
        return {"statusCode": 400, "body": json.dumps({"error": f"missing fields: {missing}"})}

    day = datetime.now(UTC).strftime("%Y-%m-%d")
    key = f"iot_data/day={day}/machine={body['machine_id']}/{datetime.now(UTC).isoformat()}.json"

    s3.put_object(Bucket=BUCKET, Key=key, Body=json.dumps(body).encode("utf-8"))
    return {"statusCode": 200, "body": json.dumps({"message": "Data stored successfully"})}


Deploy and test with sample input:

{
  "machine_id": "M-1",
  "temperature": 45.5,
  "vibration": 0.9,
  "timestamp": "2025-11-10T10:00:00Z"
}


✅ Expected result: Status 200, and JSON file appears in S3.

🌐 Step 4 – Create API Gateway (HTTP API)

1. Go to **API Gateway → Create API**
2. Choose **HTTP API → Build**
3. Integration: **Lambda** → select **process_iot_data**
4. Route: **POST /upload**
5. Stage: **dev**
6. Click **Create**

Copy Invoke URL, e.g.
_**https://abcd1234.execute-api.eu-north-1.amazonaws.com/dev/upload**_

✅ Test via Postman or cURL:

curl -X POST https://abcd1234.execute-api.eu-north-1.amazonaws.com/dev/upload \
-H "Content-Type: application/json" \
-d '{"machine_id":"M-1","temperature":77.1,"vibration":1.2,"timestamp":"2025-11-10T10:10:00Z"}'


You should get:

{"message": "Data stored successfully"}

💻 Step 5 – Run Local Sensor Simulator

Run this locally on your computer to simulate IoT devices:

mkdir -p machine-data-demo/src
cd machine-data-demo
python -m venv .venv && source .venv/bin/activate
pip install requests


Create **src/sensor_simulator.py**:

import json, random, time, requests
from datetime import datetime, UTC

API_URL = "https://abcd1234.execute-api.eu-north-1.amazonaws.com/dev/upload"  # Replace with yours

def gen():
    return {
        "machine_id": f"M-{random.randint(1,3)}",
        "temperature": round(random.uniform(20, 95), 2),
        "vibration": round(random.uniform(0.05, 2.5), 2),
        "timestamp": datetime.now(UTC).isoformat()
    }

if __name__ == "__main__":
    for _ in range(20):
        payload = gen()
        r = requests.post(API_URL, json=payload, timeout=10)
        print(r.status_code, payload)
        time.sleep(3)


Run it:

python src/sensor_simulator.py


✅ You should see 200 responses and JSON files in S3.

🧮 Step 6 – Create Glue Database & Crawler

1. Go to **AWS Glue → Databases → Create database**

- Name: **machine_data_db**

2. Go to **Crawlers → Create crawler**

- Name: **iot_data_crawler**
- Data source: **s3://kc-machine-data-yourname/iot_data/**
- IAM role: new one (Glue will request read access)
- Target database: **machine_data_db**
- Schedule: **On demand**
- Create → **Run crawler**

3. When finished, you’ll see a table (e.g. **iot_data**).

🔍 Step 7 – Query in Athena

1. Go to **Athena**
2. Set query results location:
**s3://kc-machine-data-yourname-athena-results/**
3. Choose database: **machine_data_db**

Run:

SHOW COLUMNS IN machine_data_db."iot_data";


Then:

SELECT
  regexp_extract("$path", 'machine=([^/]+)/', 1) AS machine,
  regexp_extract("$path", 'day=([0-9\-]+)/', 1)  AS day,
  CAST(temperature AS DOUBLE) AS temperature,
  CAST(vibration AS DOUBLE) AS vibration,
  timestamp AS ts
FROM machine_data_db."iot_data"
ORDER BY ts DESC
LIMIT 50;


✅ You should see data from S3.

📊 Step 8 – (Optional) Streamlit Dashboard

Install:

pip install streamlit boto3 pandas


Create **src/dashboard.py**:

import streamlit as st
import pandas as pd
import boto3, json

BUCKET = "kc-machine-data-yourname"
PREFIX = "iot_data/"

s3 = boto3.client("s3")

@st.cache_data(ttl=30)
def load_data():
    resp = s3.list_objects_v2(Bucket=BUCKET, Prefix=PREFIX)
    data = []
    for obj in resp.get("Contents", []):
        if obj["Key"].endswith(".json"):
            file = s3.get_object(Bucket=BUCKET, Key=obj["Key"])
            data.append(json.loads(file["Body"].read()))
    return pd.DataFrame(data)

st.title("Machine Data Dashboard")
df = load_data()

if df.empty:
    st.info("No data found. Run the simulator first.")
else:
    st.dataframe(df.tail(20))
    agg = df.groupby("machine_id")[["temperature","vibration"]].mean().reset_index()
    st.bar_chart(agg.set_index("machine_id"))


Run:

streamlit run src/dashboard.py

🧰 Troubleshooting
| Problem                      | Likely Cause                    | Fix                                |
| ---------------------------- | ------------------------------- | ---------------------------------- |
| 500 from API                 | Lambda error                    | Check CloudWatch logs              |
| `KeyError: 'BUCKET_NAME'`    | Missing env var                 | Add `BUCKET_NAME` in Lambda config |
| `AccessDenied`               | Lambda role lacks S3 permission | Attach `AmazonS3FullAccess`        |
| No file in S3                | Wrong API URL                   | Use `/dev/upload` stage            |
| `COLUMN_NOT_FOUND` in Athena | Schema mismatch                 | Use `SHOW COLUMNS` and correct SQL |

🧹 Cleanup

1. Delete API Gateway
2. Delete Lambda function
3. Delete Glue Crawler & Database
4. Delete Athena results bucket
5. Delete S3 bucket
6. Delete IAM Role (if created only for this demo)


