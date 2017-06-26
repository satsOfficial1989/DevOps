from flask import Flask
app = Flask(__name__)

@app.route('/')
def sample():
    return "<h1 style='color:red'>Deloitte Cloud DevOps Demo Website</h1>"
    
if __name__ == '__main__':
    app.run()
