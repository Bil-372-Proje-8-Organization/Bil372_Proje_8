# Bil 372 - Project

## Additional Note
In order to pull the most recent version, write pull from 'reverted' branch by writing the following command
git pull origin reverted

## Description
Kazıklan-ma is a car selling website, designed to eliminate price hike of pre-owned vehicles. To do so, it prevents sellers from putting higher price tags than the ones in the official price lists. Furthermore, buyers are shown with average and dealer prices for each car alongside the seller price.

## Team
Abdulkadir Özpolat <br>
Atahan Ünal <br>
Cenk Göktürk <br>
Elif Nur Afşar <br>

### Downloading the code

1. Download the zip from GitHub
2. Change the name of the downloaded folder to “project”
3. Open a terminal and execute the following commands

```bash
cd project
```

### Creating a virtual python environment

- Execute the following commands line by line

For MacOS/Linux

```bash
pip3 install -U pip
pip3 install virtualenv
virtualenv venv
source venv/bin/activate
```

For Windows

```bash
pip3 install -U pip
pip3 install virtualenv --system-site-packages -p python ./venv
virtualenv venv
.\venv\Scripts\activate
```

### Install postgres & flask

```bash
brew install postgres
pip3 install flask-wtf
pip install flask
pip install Flask-login
pip install Flask-SQLAlchemy
pip install psycopg2
```

### Accessing the database (Optional)

This step is entirely optional and does not need to be followed in order to run the application. 

- To access

```bash
psql postgres://heqvalntzxdxvf:b86b019f8813b8316172a0af55578c01763592f5bb4f242ab577fb5c7616f0dc@ec2-50-17-197-184.compute-1.amazonaws.com:5432/d6uhfb7evc3bsm
```

- To exit

```bash
exit or \d (and afterwards press enter)
```

### Run the application

- Write the following command in the terminal

```bash
python3 application.py
```

- Access the running project from browser by

```bash
localhost:5000 or 127.0.0.1:5000
```

- Exit the program by writing the following command in the terminal

```bash
exit
```
