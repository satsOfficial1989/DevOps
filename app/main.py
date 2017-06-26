from flask import Flask
app = Flask(__name__)

@app.route('/')
def sample():
    return "<h2 style='color:green'>Deloitte Cloud DevOps Demo Web Application Home </h2>"
    
if __name__ == '__main__':
    app.run()
