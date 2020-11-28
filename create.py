from flask import Flask
from models import *

app = Flask(__name__)

#to connect to the database that is hosted on Heroku
app.config['SQLALCHEMY_DATABASE_URI']= 'postgres://heqvalntzxdxvf:b86b019f8813b8316172a0af55578c01763592f5bb4f242ab577fb5c7616f0dc@ec2-50-17-197-184.compute-1.amazonaws.com:5432/d6uhfb7evc3bsm'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']=False

db.init_app(app)
def main():
    db.create_all()

if __name__ == "__main__":
    with app.app_context():
        main()
