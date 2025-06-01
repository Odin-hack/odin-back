from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
from pytrends.request import TrendReq

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

pytrends = TrendReq()

@app.get("/trends")
def get_trends(keyword: str = Query(...)):
    pytrends.build_payload([keyword], timeframe='now 7-d', geo='')
    data = pytrends.interest_by_region()
    result = data[keyword].sort_values(ascending=False).head(5).to_dict()
    return result
