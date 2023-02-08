import os
from flask import Flask, render_template, request, url_for, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from marshmallow import fields, Schema



app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://localhost/template1'
db = SQLAlchemy(app)
ma = Marshmallow(app)


class CurrencyRates(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    date = db.Column(db.DateTime, unique=True, nullable=False)
    eur = db.Column(db.Float, nullable=False)
    cad = db.Column(db.Float, nullable=False)
    pln = db.Column(db.Float, nullable=False)
    uah = db.Column(db.Float, nullable=False)


class CurrencyRatesSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = CurrencyRates
