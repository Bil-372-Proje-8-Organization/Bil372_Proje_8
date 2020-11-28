from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import InputRequired, Length, EqualTo, ValidationError
from models import User


def invalid_credentials(form, field):
    """ authentication of user  """

    hashed_pswd  = field.data
    username = form.username.data


    # Check username is invalid
    user_data = User.query.filter_by(username=username).first()
    if user_data is None:
        raise ValidationError("Either username or password is incorrect")

    # Check hashed_pswd  in invalid
    elif not (hashed_pswd == user_data.hashed_pswd ):
        raise ValidationError("Either username or password is incorrect")


class RegistrationForm(FlaskForm):
    """ Signup """

    username = StringField('username', validators=[InputRequired(message="Username required"), Length(min=4, max=25, message="Username must be between 4 and 25 characters")])
    hashed_pswd  = PasswordField('hashed_pswd', validators=[InputRequired(message="hashed_pswd  required"), Length(min=4, max=25, message="hashed_pswd  must be between 4 and 25 characters")])
    confirm_pswd = PasswordField('confirm_pswd', validators=[InputRequired(message="hashed_pswd  required"), EqualTo('hashed_pswd', message="Passwords must match")])

    def validate_username(self, username):
        user_object = User.query.filter_by(username=username.data).first()
        if user_object:
            raise ValidationError("Username already exists. Select a different username.")

class LoginForm(FlaskForm):
    """ Signin """

    username = StringField('username', validators=[InputRequired(message="Username required")])
    hashed_pswd  = PasswordField('hashed_pswd', validators=[InputRequired(message="hashed_pswd  required"), invalid_credentials])
