import re
from string import whitespace, punctuation

path = r"C:\Users\PeacocCo\OneDrive - Coherent, Inc\Documents\GitHub\Power-BI-Automation\test_dataflows"
name = "test_search_fin_common_flow.txt"

with open(f"{path}\\{name}", "r") as dataflow:
    data = dataflow.read()


tables = [
    s.split("=")[1].replace("Name", "")
    for s in re.findall(r"Name\s+.\s+.\W+.\w+", data)
    if all(["XX" in s, "_" in s])
]
shared = [
    s.split("=")[0].replace("shared", "") for s in re.findall(r"shared\D+.\=", data)
]

tables = [t.replace(p, "") for p in punctuation for t in tables]
shared = [s.replace(p, "") for p in punctuation for s in shared]

for idx, table in enumerate(tables):
    print(idx, table)

for idx, table in enumerate(shared):
    print(idx, table)
