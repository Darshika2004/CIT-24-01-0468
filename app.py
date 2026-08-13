import os
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    db_host = os.getenv('DB_HOST', 'postgres-db')
    return f"<h1>CCS3308 Virtualization Assignment</h1><p>Web service connected to DB host: {db_host}</p>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
