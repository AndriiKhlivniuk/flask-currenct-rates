import os
from flask import Flask, render_template, request, url_for, redirect, abort
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime




app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://localhost/andreykhlivniuk'
db = SQLAlchemy(app)


class Currency(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    code = db.Column(db.String(3), nullable=False)
    rates = db.relationship('CurrencyRates', back_populates='currency')
    current_rate = db.relationship('CurrencyRates', uselist=False, overlaps="rates",
                                    order_by='desc(CurrencyRates.date)')

class CurrencyRates(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    date = db.Column(db.DateTime(timezone=True), nullable=False, default=datetime.now())
    currency_id = db.Column(db.Integer, db.ForeignKey('currency.id'), nullable=False)
    rate = db.Column(db.Float, nullable=False)
    currency = db.relationship('Currency', back_populates='rates', uselist=False)



