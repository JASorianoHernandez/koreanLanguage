import csv
import requests
from bs4 import BeautifulSoup

# Set up the URL for the search
url = "https://en.dict.naver.com/#/search?range=example&query=apple"

# Send a GET request to the URL
response = requests.get(url)

# Parse the HTML content using BeautifulSoup
soup = BeautifulSoup(response.content, 'html.parser')

# Extract the meaning and example sentence for the word
meaning = soup.find('span', {'class': 'mean'}).text.strip()
example = soup.find('div', {'class': 'section_ex'}).find('li').text.strip()

# Create a dictionary to store the data
data = {'Word': 'apple', 'Meaning': meaning, 'Example': example}

# Write the data to a CSV file
with open('apple.csv', 'w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=['Word', 'Meaning', 'Example'])
    writer.writeheader()
    writer.writerow(data)

