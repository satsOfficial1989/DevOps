from flask import Flask
app = Flask(__name__)

@app.route('/')
def sample():
    return "<h2 style='color:green'>Welcome to Deloitte Cloud CICD Demo - This is Change#1 </h2>"
    
if __name__ == '__main__':
    app.run()
