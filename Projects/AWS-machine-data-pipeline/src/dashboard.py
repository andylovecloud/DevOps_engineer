import streamlit as st, pandas as pd, boto3, json

st.title("Machine Telemetry Dashboard (Demo)")

BUCKET = "kc-machine-data-<yourname>"
PREFIX = "iot_data/"

s3 = boto3.client("s3")

@st.cache_data(ttl=30)
def load_data():
    objs = s3.list_objects_v2(Bucket=BUCKET, Prefix=PREFIX)
    rows = []
    for o in objs.get('Contents', []):
        if o['Key'].endswith(".json"):
            body = s3.get_object(Bucket=BUCKET, Key=o['Key'])['Body'].read()
            d = json.loads(body)
            rows.append(d)
    return pd.DataFrame(rows)

df = load_data()
if df.empty:
    st.info("No data yet.")
else:
    st.dataframe(df.tail(20), use_container_width=True)
    st.subheader("Average by Machine")
    agg = df.groupby("machine_id")[["temperature","vibration"]].mean().reset_index()
    st.bar_chart(agg.set_index("machine_id"))
