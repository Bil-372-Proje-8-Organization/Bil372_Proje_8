import os
import time
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, login_user, current_user, logout_user
from sqlalchemy import select,update, and_
#from flask_socketio import SocketIO, join_room, leave_room, send

from wtform_fields import *
from models import *


# Configure app
app = Flask(__name__)
app.secret_key='secret_key'
app.config['WTF_CSRF_SECRET_KEY'] = "b'f\xfa\x8b{X\x8b\x9eM\x83l\x19\xad\x84\x08\xaa"

# Configure database
app.config['SQLALCHEMY_DATABASE_URI']= 'postgres://heqvalntzxdxvf:b86b019f8813b8316172a0af55578c01763592f5bb4f242ab577fb5c7616f0dc@ec2-50-17-197-184.compute-1.amazonaws.com:5432/d6uhfb7evc3bsm'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
conn=db.engine.connect()
# Initialize login manager
login = LoginManager(app)
login.init_app(app)

Advert = db.Table('advertisement', db.metadata, autoload=True, autoload_with=db.engine)
Users_info = db.Table('users_info', db.metadata, autoload=True, autoload_with=db.engine)

#added by elif
sayac=7


@login.user_loader
def load_user(id):
    return User.query.get(int(id))

#socketio = SocketIO(app, manage_session=False)
#ROOMS = ["lounge", "news", "games", "coding"]


@app.route("/", methods=['GET', 'POST'])
def index():

    reg_form = RegistrationForm()
    if reg_form.validate_on_submit():
        username = reg_form.username.data
        hashed_pswd  = reg_form.hashed_pswd.data

        # Hash hashed_pswd
        #hashed_pswd  = pbkdf2_sha256.hash(hashed_pswd )
        user = User(username=username, hashed_pswd =hashed_pswd )
        db.session.add(user)
        db.session.commit()

        flash('Registered successfully. Please login.', 'success')
        return redirect(url_for('login'))

    return render_template("index.html", form=reg_form)


@app.route("/login", methods=['GET', 'POST'])
def login():

    login_form = LoginForm()

    # Allow login if validation success
    if login_form.validate_on_submit():
        user_object = User.query.filter_by(username=login_form.username.data).first()
        login_user(user_object)
        return redirect(url_for('home'))

    return render_template("login.html", form=login_form)


@app.route("/logout", methods=['GET'])
def logout():

    # Logout user
    logout_user()
    flash('You have logged out', 'success')
    return redirect(url_for('login'))


@app.route("/home", methods=['GET', 'POST'])
def home():

    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))
    
    return render_template("home.html", username=current_user.username,  adverts=db.session.query(Advert).all())

@app.route("/profile", methods=['GET', 'POST'])
def profile():
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))

    return render_template("profile.html", username=current_user.username,  Users_info=db.session.query(Users_info).filter_by(username=current_user.username).all())

@app.route("/your_adverts", methods=['GET', 'POST'])
def your_adverts():
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))   
    query = select([Advert]).where(Advert.c.seller_id == current_user.id)
    adverts= conn.execute(query)
    return render_template("your_adverts.html", username=current_user.username,  adverts=adverts)

@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('404.html'), 404

@app.route("/edit_advert/<int:id>", methods=['GET', 'POST'])
def editAdvert(id):
  if request.method =='POST':
      values = {
      'seller_price':request.form['seller_price'],
      'dealer_price':request.form['dealer_price'],
      'swop':request.form['swop'],
      'pre_owned':request.form['pre_owned']
      }
      query = update(Advert).where(Advert.c.ad_no == id).values(values)
      conn.execute(query)
      return redirect(url_for('your_adverts'))  
  query = select([Advert]).where(Advert.c.ad_no == id)
  advert= conn.execute(query).fetchone()
  return render_template('editAdvert.html', advert=advert)

#need some changes in database after that it is done
'''
@app.route("/addAdvert", methods=['GET', 'POST'])
def addAdvert():
  if request.method =='POST':
      values = {
      'seller_price':request.form['seller_price'],
      'dealer_price':request.form['dealer_price'],
      'swop':request.form['swop'],
      'pre_owned':request.form['pre_owned']
      }
      ##counter must need to be increment in database
      #ins = Advert.insert().values(7, values, current_user.id) 
      flash('Inserted successfully!', 'success')
      return redirect(url_for('addAdvert'))
  query = select([Advert]).where(Advert.c.users_id == current_user.id)
  adverts = conn.execute(query)
  return redirect(url_for('your_adverts')) '''


@app.route("/delete_advert/<int:id>")
def deleteAdvert(id):
  query = Advert.delete().where(Advert.c.ad_no == id)
  conn.execute(query)
  return redirect(url_for('your_adverts'))


@app.route("/edit_profile/<int:id>", methods=['GET', 'POST'])
def editProfile(id):
  if request.method =='POST':
      values = {
      'name':request.form['name'],
      'surname':request.form['surname'],
      'city':request.form['city'],
      'district':request.form['district'],
      'phone':request.form['phone'],
      'mail':request.form['mail']
      }
      query = update(Users_info).where(Users_info.c.users_id == id).values(values)
      conn.execute(query)
      return redirect(url_for('profile'))
  query = select([Users_info]).where(Users_info.c.users_id == id)
  users_info= conn.execute(query).fetchone()
  return render_template('editProfile.html', users_info=users_info)

if __name__ == "__main__":
    app.run(debug=True)
