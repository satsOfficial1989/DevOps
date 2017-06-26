from flask import Flask
app = Flask(__name__)

@app.route('/')
def sample():
    return "<h2 style='color:blue'>Deloitte Cloud DevOps Demo Web Application</h2>"
    
if __name__ == '__main__':
    app.run()
