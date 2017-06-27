from flask import Flask
app = Flask(__name__)

@app.route('/')
def sample():
    return "<body style='background-color:red;'><p style='text-align:center'><font face='verdana' color='black' size='6'>Demo Client Web Application</p></font></body>"
    
if __name__ == '__main__':
    app.run()

