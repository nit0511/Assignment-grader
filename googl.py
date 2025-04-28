import requests

url = "https://www.googleapis.com/customsearch/v1"
params = {
    "key": "AIzaSyB0tdvgTbE72jDVLnM56rWAfzVm7UlljWQ" ,
    "cx": "4642b937b1a204219",
    "q": "Model Context Protocol MCP"
}

response = requests.get(url, params=params)
print(response.json())
