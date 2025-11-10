AWS Machine Data Pipeline (Serverless IoT Demo)

A hands-on, end-to-end demo that simulates machine telemetry and builds a serverless data pipeline on AWS:

Data Ingestion: Python simulator → API Gateway

Processing & Storage: AWS Lambda → Amazon S3 (Data Lake)

Catalog & Query: AWS Glue (Crawler) → Amazon Athena

Visualization (optional): Streamlit dashboard

This project is intentionally minimal, reproducible on AWS Free Tier, and structured to mirror an industrial IoT flow.

Table of Contents

Architecture & Why These Services

Prerequisites

Variables & Naming

Step 1 — Create S3 Data Lake

Step 2 — Create Lambda Execution Role (IAM)

Step 3 — Create Lambda Function

Step 4 — Create API Gateway (HTTP API)

Step 5 — Run Local Sensor Simulator

Step 6 — Create Glue Database & Crawler

Step 7 — Query in Athena

Step 8 — (Optional) Streamlit Dashboard

Troubleshooting

Cleanup

Screenshots to Capture

Architecture & Why These Services
Python Sensor Simulator
        |  (HTTPS JSON)
        v
Amazon API Gateway (HTTP API)
        v
AWS Lambda (process_iot_data)
        v
Amazon S3 (Data Lake: raw JSON, partitioned by day/machine)
        v
AWS Glue Crawler (schema discovery) + Amazon Athena (SQL analytics)
        v
(Optional) Streamlit Dashboard (visualize latest metrics)


Amazon API Gateway (HTTP API): Secure, scalable public endpoint to receive incoming JSON telemetry.

AWS Lambda: Serverless compute to validate and store events. No servers to manage; scales on demand.

Amazon S3: Durable, low-cost data lake storage for raw telemetry (JSON). Easy to query later.

AWS Glue Crawler: Auto-discovers table schema over S3 paths and registers to the Data Catalog.

Amazon Athena: Serverless SQL query engine for S3. Pay per data scanned; perfect for ad-hoc analysis.

Streamlit (optional): Quick local app to visualize metrics without standing up a full BI tool.

Prerequisites

AWS account (Free Tier is fine)

Python 3.10+ on your local machine

AWS CLI v2 installed and configured:

aws configure
# Provide: AWS Access Key, Secret, Default region (e.g., eu-north-1), output json

Variables & Naming

Decide these once and reuse consistently:

AWS Region: eu-north-1 (Stockholm) or your nearest

S3 bucket for data lake: kc-machine-data-<yourname> (must be globally unique, lowercase)

Lambda function name: process_iot_data

API stage name: dev

Glue database name: machine_data_db

Partitioned layout in S3 (created by Lambda):
s3://kc-machine-data-<yourname>/iot_data/day=YYYY-MM-DD/machine=M-1/<timestamp>.json

Step 1 — Create S3 Data Lake

Console: AWS → S3 → Create bucket

Name: kc-machine-data-<yourname>

Region: same as your Lambda/API (e.g., eu-north-1)

Block public access: On (default)

Create bucket

No folders needed; Lambda will write keys with iot_data/....

Step 2 — Create Lambda Execution Role (IAM)

Console: AWS → IAM → Roles → Create role

Trusted entity: AWS service → Lambda

Permissions (demo/learning):

AmazonS3FullAccess

CloudWatchLogsFullAccess

Role name: lambda_s3_writer_role

Create role

In production, replace the broad policies with least-privilege grants scoped to your bucket and logs.

Step 3 — Create Lambda Function

Console: AWS → Lambda → Create function

Author from scratch

Name: process_iot_data

Runtime: Python 3.12 (or 3.11+)

Architecture: x86_64 (default)

Execution role: Use existing role → select lambda_s3_writer_role

Create function

Add environment variable:

Key: BUCKET_NAME

Value: kc-machine-data-<yourname>

Paste Lambda code (click Code tab → replace with below → Deploy):

import json
import os
import boto3
from datetime import datetime, UTC
import base64

s3 = boto3.client("s3")
BUCKET = os.environ["BUCKET_NAME"]  # set in Lambda > Configuration > Environment variables

def _get_body(event):
    """
    Supports both API Gateway (HTTP API) and direct test invocation.
    - If API Gateway: event['body'] may be JSON string or base64 JSON.
    - If direct: event itself may be the JSON dict.
    """
    if isinstance(event, dict) and "body" in event and event["body"] is not None:
        body_raw = event["body"]
        if event.get("isBase64Encoded"):
            body_raw = base64.b64decode(body_raw).decode("utf-8")
        return json.loads(body_raw)
    return event if isinstance(event, dict) else {}

def lambda_handler(event, context):
    body = _get_body(event)

    # Minimal validation
    required = ["machine_id", "temperature", "vibration", "timestamp"]
    missing = [k for k in required if k not in body]
    if missing:
        return {"statusCode": 400, "body": json.dumps({"error": f"missing fields: {missing}"})}

    # Partition keys: day & machine
    day = datetime.now(UTC).strftime("%Y-%m-%d")
    key = f"iot_data/day={day}/machine={body['machine_id']}/{datetime.now(UTC).isoformat()}.json"

    # Write as compact JSON
    s3.put_object(
        Bucket=BUCKET,
        Key=key,
        Body=json.dumps(body, separators=(",", ":")).encode("utf-8")
    )

    return {"statusCode": 200, "body": json.dumps({"message": "Data stored successfully", "s3_key": key})}


Quick self-test inside Lambda (no API yet):

Click Test

Create event test1 with:

{
  "machine_id": "M-1",
  "temperature": 55.2,
  "vibration": 0.8,
  "timestamp": "2025-11-10T09:37:00Z"
}


Test → expect Status: Succeeded.
Check S3: a new object appears under iot_data/day=.../machine=M-1/...json.

If it fails, see Troubleshooting
.

Step 4 — Create API Gateway (HTTP API)

Console: AWS → API Gateway → Create API

Choose HTTP API → Build

Integrations: Lambda → select process_iot_data

API name: machine-data-api

Next

Routes: Add POST /upload → integration = process_iot_data

Next

Stage name: dev

Create

Copy the Invoke URL, e.g.:
https://abcd1234.execute-api.eu-north-1.amazonaws.com/dev
Your full endpoint is:
https://abcd1234.execute-api.eu-north-1.amazonaws.com/dev/upload

(Optional) Test via Postman:

POST /dev/upload
Content-Type: application/json
{
  "machine_id": "M-1",
  "temperature": 82.5,
  "vibration": 1.2,
  "timestamp": "2025-11-10T12:15:00Z"
}


Expect {"message":"Data stored successfully", ...} and a new object in S3.

Step 5 — Run Local Sensor Simulator

On your local machine (not AWS):

mkdir -p machine-data-demo/src
cd machine-data-demo
python -m venv .venv && source .venv/bin/activate
pip install requests


Create src/sensor_simulator.py:

import json, random, time, requests
from datetime import datetime, UTC

API_URL = "https://<your-api-id>.execute-api.<region>.amazonaws.com/dev/upload"  # replace

def gen():
    return {
        "machine_id": f"M-{random.randint(1,3)}",
        "temperature": round(random.uniform(20, 95), 2),
        "vibration": round(random.uniform(0.05, 2.5), 2),
        "timestamp": datetime.now(UTC).isoformat()
    }

if __name__ == "__main__":
    # send 20 samples then exit
    for _ in range(20):
        payload = gen()
        r = requests.post(API_URL, json=payload, timeout=10)
        print(r.status_code, r.text, payload)
        time.sleep(3)


Run it:

python src/sensor_simulator.py


Expect HTTP 200 responses and new JSON objects in S3 every ~3 seconds.

Step 6 — Create Glue Database & Crawler

Console: AWS → Glue

Database:

Data Catalog → Databases → Create database

Name: machine_data_db

Crawler:

Crawlers → Create crawler

Name: iot_data_crawler

Data source: S3 → Prefix = s3://kc-machine-data-<yourname>/iot_data/

IAM role: create a new one (Glue will request S3 read)

Output: Database = machine_data_db (leave table prefix empty)

Schedule: On-demand

Create → Run crawler

Verify table:

After it finishes, open Tables → you should see a new table (e.g., iot_data) in machine_data_db.

Note: Depending on files, the crawler may infer explicit JSON columns (best) or a single raw column. We’ll cover both in the next step.

Step 7 — Query in Athena

Console: AWS → Athena

Set query result location (first time only):
Settings → Manage → s3://kc-machine-data-<yourname>-athena-results/ (create bucket if needed)

Select data source & database:
Data source: AwsDataCatalog → Database: machine_data_db

Discover table schema:

SHOW TABLES IN machine_data_db;
SHOW COLUMNS IN machine_data_db."iot_data";

A) If Glue created explicit columns (machine_id, temperature, vibration, timestamp)

Use $path to extract partition info from S3 keys:

SELECT
  regexp_extract("$path", 'machine=([^/]+)/', 1) AS machine_from_path,
  regexp_extract("$path", 'day=([0-9\-]+)/', 1)  AS day_from_path,
  CAST(temperature AS DOUBLE) AS temperature,
  CAST(vibration  AS DOUBLE)  AS vibration,
  timestamp AS ts
FROM machine_data_db."iot_data"
ORDER BY ts DESC
LIMIT 50;


Average by machine:

SELECT
  regexp_extract("$path", 'machine=([^/]+)/', 1) AS machine_from_path,
  AVG(CAST(temperature AS DOUBLE)) AS avg_temp,
  AVG(CAST(vibration  AS DOUBLE))  AS avg_vibration,
  COUNT(*) AS samples
FROM machine_data_db."iot_data"
GROUP BY 1
ORDER BY 1;

B) If Glue created a single raw JSON column (e.g., _col0 or data)

Replace the column name accordingly and parse fields:

SELECT
  regexp_extract("$path", 'machine=([^/]+)/', 1) AS machine_from_path,
  regexp_extract("$path", 'day=([0-9\-]+)/', 1)  AS day_from_path,
  CAST(json_extract_scalar(data, '$.temperature') AS DOUBLE) AS temperature,
  CAST(json_extract_scalar(data, '$.vibration')  AS DOUBLE) AS vibration,
  json_extract_scalar(data, '$.timestamp') AS ts
FROM machine_data_db."iot_data"
ORDER BY ts DESC
LIMIT 50;


Use SHOW COLUMNS to confirm the actual raw column name (e.g., _col0, data, value).

Step 8 — (Optional) Streamlit Dashboard

Local visualization pulling raw JSON files from S3.

pip install streamlit boto3 pandas


Create src/dashboard.py:

import streamlit as st
import pandas as pd
import boto3, json
from collections import defaultdict

BUCKET = "kc-machine-data-<yourname>"
PREFIX = "iot_data/"

s3 = boto3.client("s3")

@st.cache_data(ttl=30)
def load_data():
    resp = s3.list_objects_v2(Bucket=BUCKET, Prefix=PREFIX)
    rows = []
    for o in resp.get("Contents", []):
        if o["Key"].endswith(".json"):
            body = s3.get_object(Bucket=BUCKET, Key=o["Key"])["Body"].read()
            d = json.loads(body)
            rows.append(d)
    return pd.DataFrame(rows) if rows else pd.DataFrame(columns=["machine_id","temperature","vibration","timestamp"])

st.title("Machine Telemetry Dashboard (Demo)")

df = load_data()
if df.empty:
    st.info("No data yet. Run the simulator first.")
else:
    st.dataframe(df.tail(20), use_container_width=True)
    st.subheader("Average by Machine")
    agg = df.groupby("machine_id")[["temperature","vibration"]].mean().reset_index()
    st.bar_chart(agg.set_index("machine_id"))


Run:

streamlit run src/dashboard.py

Troubleshooting
Symptom / Error	Likely Cause	Fix
500 from simulator/Postman	Lambda error	Check CloudWatch Logs: Lambda → Monitor → View logs
KeyError: 'BUCKET_NAME'	Env var missing	Lambda → Configuration → Environment variables → add BUCKET_NAME
AccessDenied on put_object	Lambda role lacks S3 permissions	IAM role → attach AmazonS3FullAccess (demo) or a scoped policy
No files in S3	API URL wrong or Lambda failed	Confirm API stage path (/dev/upload), check Lambda logs
Athena: COLUMN_NOT_FOUND: _col0	Crawler inferred explicit columns	Use explicit columns as shown in step 7A, or check SHOW COLUMNS
Athena returns zero rows	Wrong LOCATION/Prefix or no data	Verify S3 path and that objects exist under iot_data/...
DeprecationWarning for UTC	datetime.utcnow() deprecated	Use datetime.now(UTC)

Where to find logs:
Lambda → Monitor → View logs in CloudWatch → open latest log stream.

Cleanup

Avoid ongoing charges by removing:

API Gateway (the HTTP API you created)

Lambda function process_iot_data

Glue crawler and database machine_data_db

Athena query results bucket (if created)

S3 data lake bucket kc-machine-data-<yourname> (empty it before deleting)

Any role/policies created exclusively for this demo
