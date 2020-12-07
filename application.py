import os
import time
from flask import Flask, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, login_user, current_user, logout_user
from sqlalchemy import select,update, and_
from sqlalchemy import func
from datetime import datetime, date, timedelta
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
Brand = db.Table('model', db.metadata, autoload=True, autoload_with=db.engine)
Vehicle = db.Table('vehicle', db.metadata, autoload=True, autoload_with=db.engine)
Model = db.Table('model', db.metadata, autoload=True, autoload_with=db.engine)
City = db.Table('city', db.metadata, autoload=True, autoload_with=db.engine)



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

        flash('User created successfully. Now, please add personal info', 'success')
        return redirect(url_for('addProfile', username=username))

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
    if current_user.username == 'admin':
        return render_template("adminHome.html", filter=False ,username=current_user.username,  adverts=db.session.query(Advert).all(), Users_info=db.session.query(Users_info).all(), vehicles=db.session.query(Vehicle).all())
    return render_template("home.html",  filter=False,username=current_user.username,  adverts=db.session.query(Advert).all(), Users_info=db.session.query(Users_info).all(), vehicles=db.session.query(Vehicle).all())

@app.route("/addProfile/<username>", methods=['GET', 'POST'])
def addProfile(username):
    if request.method =='POST':
        values = {
        'users_id':db.session.query(User).filter_by(username=username).with_entities(User.id).first(),
        'name':request.form['name'],
        'surname': request.form['surname'],
        'city':request.form['city'],
        'district': request.form['district'],
        'phone':request.form['phone'],
        'mail': request.form['mail']
        }
        query = Users_info.insert().values(values)
        conn.execute(query)
        return redirect(url_for('login'))
    return render_template("newProfile.html", cities=db.session.query(City).all())

@app.route("/addBrand", methods=['GET', 'POST'])
def addBrand():
    if request.method =='POST':
        values = {
        'brand_name':request.form['brand_name'],
        'model_name':request.form['model_name'],
        'brand_model': request.form['brand_name'] + '-' + request.form['model_name']
        }
        query = Brand.insert().values(values)
        conn.execute(query)
        return redirect(url_for('brands'))  
    return render_template('newBrand.html')

@app.route("/addVehicle", methods=['GET', 'POST'])
def addVehicle():
    if request.method =='POST':
        values = {
        'brand_model':request.form['brand_model'],
        'transmission':request.form['transmission'],
        'engine_size': request.form['engine_size'], 
        'package': request.form['package'], 
        'drive_train': request.form['drive_train'], 
        'num_cylinder': request.form['num_cylinder'], 
        'power': request.form['power'], 
        'dealer_price': request.form['dealer_price'],
        'type': request.form['type'],
        'year': request.form['year'],
        }
        query = Vehicle.insert().values(values)
        conn.execute(query)
        return redirect(url_for('vehicles'))  

    return render_template('newVehicle.html', models=db.session.query(Model).all())    

@app.route("/newAdvert", methods=['GET', 'POST'])
def newAdvert():
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))
    if request.method =='POST':
        brand_model=request.form['brand_model']
        date=datetime.today()
        values = {
        'seller_id':db.session.query(User).filter_by(username=current_user.username).with_entities(User.id).first(),
        'ad_date':date,
        'seller_price':request.form['seller_price'],
        'vehicle_no':db.session.query(Vehicle).filter_by(brand_model=brand_model).with_entities(Vehicle.c.vehicle_no).first(),
        'km': request.form['km'],
        'color': request.form['color'],
        'damage': request.form['damage'],
        'second_hand': request.form['second_hand'],
        'warranty': request.form['warranty'],
        'exchange': request.form['exchange'],
        }
        query = Advert.insert().values(values)
        conn.execute(query)
        return redirect(url_for('adverts'))

    return render_template("newAdvert.html", id=current_user.id, models=db.session.query(Model).all())


@app.route("/yourAdverts", methods=['GET', 'POST'])
def adverts():
    return render_template("your_adverts.html", id=current_user.id, adverts=db.session.query(Advert).filter_by(seller_id=current_user.id).all(), Users_info=db.session.query(Users_info).all(), vehicles=db.session.query(Vehicle).all())

 

@app.route("/allBrands", methods=['GET', 'POST'])
def brands():
    return render_template('allBrands.html', brands=db.session.query(Model).all())

@app.route("/allVehicles", methods=['GET', 'POST'])
def vehicles():
    return render_template('allVehicles.html', vehicles=db.session.query(Vehicle).all())

@app.route("/deleteBrand/<brand_model>")
def deleteBrand(brand_model):
  query = Model.delete().where(Model.c.brand_model == brand_model)
  conn.execute(query)
  return redirect(url_for('brands'))

@app.route("/deleteVehicle/<vehicle_no>")
def deleteVehicle(vehicle_no):
  query = Vehicle.delete().where(Vehicle.c.vehicle_no == vehicle_no)
  conn.execute(query)
  return redirect(url_for('vehicles'))  

@app.route("/delete_advert/<int:id>")
def deleteAdvert(id):
  query = Advert.delete().where(Advert.c.ad_no == id)
  conn.execute(query)
  return redirect(url_for('your_adverts'))

@app.route("/profile", methods=['GET', 'POST'])
def profile():
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))

    return render_template("profile.html", id=current_user.id,  Users_info=db.session.query(Users_info).filter_by(users_id=current_user.id).all())

@app.route("/your_adverts", methods=['GET', 'POST'])
def your_adverts():
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))


    return render_template("your_adverts.html", id=current_user.id, adverts=db.session.query(Advert).filter_by(seller_id=current_user.id).all(), Users_info=db.session.query(Users_info).all(), vehicles=db.session.query(Vehicle).all())

@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('404.html'), 404

@app.route("/edit_advert/<int:id>", methods=['GET', 'POST'])
def editAdvert(id):
  if request.method =='POST':
      values = {
      'seller_price':request.form['seller_price'],
      'km':request.form['km'],
      'color': request.form['color'],
      'damage': request.form['damage'],
      'second_hand':request.form['second_hand'],
      'exchange':request.form['exchange']
      }
      query = update(Advert).where(Advert.c.ad_no == id).values(values)
      conn.execute(query)
      return redirect(url_for('your_adverts'))  
  query = select([Advert]).where(Advert.c.ad_no == id)
  advert= conn.execute(query).fetchone()
  return render_template('editAdvert.html', advert=advert)


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

@app.route("/editVehicle/<int:no>", methods=['GET', 'POST'])
def editVehicle(no):
  if request.method =='POST':
      values = {
      'brand_model':request.form['brand_model'],
      'transmission':request.form['transmission'],
      'engine_size':request.form['engine_size'],
      'package':request.form['package'],
      'drive_train':request.form['drive_train'],
      'num_cylinder':request.form['num_cylinder'],
      'power':request.form['power'],
      'dealer_price':request.form['dealer_price'],
      'type':request.form['type'],
      'year':request.form['year'],
      }
      query = update(Vehicle).where(Vehicle.c.vehicle_no == no).values(values)
      conn.execute(query)
      return redirect(url_for('vehicles'))
  query = select([Vehicle]).where(Vehicle.c.vehicle_no == no)
  vehicle = conn.execute(query).fetchone()
  return render_template('editVehicle.html', vehicle=vehicle , models=db.session.query(Model).all())


@app.route("/detailsAdvert/<int:id>", methods=['GET', 'POST'])
def detailsAdvert(id):
    if not current_user.is_authenticated:
        flash('Please login', 'danger')
        return redirect(url_for('login'))
    return render_template("detailsAdvert.html", id=current_user.id,  adverts=db.session.query(Advert).filter_by(ad_no=id).all(), Users_info=db.session.query(Users_info).all(), vehicles=db.session.query(Vehicle).all())

@app.route("/filter/", methods=['GET', 'POST'])
def filter():
    if request.method =='POST':
        min_price= request.form['min_price']
        max_price= request.form['max_price']
        min_year= request.form['min_year']
        max_year= request.form['max_year']
        if request.form['min_price'] == '':
           min_price=0
        if request.form['max_price'] == '':
           max_price=db.session.query(func.max(Advert.c.seller_price)).scalar()
        if request.form['min_year'] == '':
           min_year=1900
        if request.form['max_year'] == '':
           max_year=2022  
        query = select([Advert]).where(and_(Advert.c.seller_price <= max_price, Advert.c.seller_price >= min_price))
        adverts = conn.execute(query).fetchall()
        query = select([Vehicle]).where(and_(Vehicle.c.year <= max_year, Vehicle.c.year >= min_year, Vehicle.c.brand_model == request.form['brand_model']))
        vehicles = conn.execute(query).fetchall()
        if current_user.username == 'admin':    
            return render_template("adminHome.html", filter=True,  adverts=adverts, Users_info=db.session.query(Users_info).all(), vehicles=vehicles)
        else:
            return render_template("Home.html", filter=True,  adverts=adverts, Users_info=db.session.query(Users_info).all(), vehicles=vehicles)


    return render_template('filter.html' , models=db.session.query(Model).all())

if __name__ == "__main__":
    app.run(debug=True)
