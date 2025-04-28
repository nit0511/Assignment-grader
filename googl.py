import requests

url = "https://www.googleapis.com/customsearch/v1"
params = {
    "key": "" ,
    "cx": "",
    "q": "Model Context Protocol MCP"
}

response = requests.get(url, params=params)
print(response.json())
