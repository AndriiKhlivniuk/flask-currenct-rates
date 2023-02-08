# flask-currency-rates
<h1>Install</h1>
1. Install requirements: pip3 install -r requirements.txt<br>
2. Add db to your postgres db: psql <name of your db> < mydb.sql<br>
3. In file models.py change name to your postgres db name: <br>
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://localhost/<b>your db name</b>'<br>

<h1>Run app</h1>
export FLASK_APP=main.py && flask run<br>

<h1>Usage/h1>
1. Navigate to /actualrate/<currency_code> to see actual rate with the given currency (indicate your currency code instead <currency_code>). Example: /actualrate/uah
2. Navigate to /history/<fromdate>/<currency> to see history of rates for given currenct from given date until most recent. Supported currencies: UAH, PLN, EUR, CAD. Example: /history/2023-02-06/uah<br>



