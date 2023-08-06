import requests
from models import *
from datetime import datetime
from sqlalchemy import desc


key = "apilayer_apikey"


def update_rates(rates):
    db.create_all()

    for code, rate in rates.items():
        currency = db.session.query(Currency).filter_by(code=code).first()
        if not currency:
            currency = Currency(code=code)
            db.session.add(currency)

        new_rate = CurrencyRates(date=datetime.now(), rate=rate, currency=currency)
        db.session.add(new_rate)

        current_rate = db.session.query(CurrencyRates).filter_by(currency=currency).order_by(desc(CurrencyRates.date)).first()
        if current_rate:
            currency.current_rate = current_rate
    
    db.session.commit()




@app.route("/actualrate/<currency_code>") #add mist
def def_exteral_rate(currency_code: str):
    
    currency_code = currency_code.upper()
    if currency_code not in ['UAH', 'PLN', 'EUR', 'CAD']:
        abort(404, description="Invalid currency code")

    if currency_code!= 'UAH' or 'PLN' or 'EUR' or 'CAD':
        url = f"https://api.apilayer.com/exchangerates_data/latest?symbols={currency_code}%2C%20UAH%2C%20PLN%2C%20EUR%2C%20CAD&base=USD&base=USD"
    else:
        url = "https://api.apilayer.com/exchangerates_data/latest?symbols=UAH%2C%20PLN%2C%20EUR%2C%20CAD&base=USD"
        
    payload = {}
    headers= {
        "apikey": key
    }
    response = requests.request("GET", url, headers=headers, data = payload)
    result = response.json()
    update_rates(result['rates'])

    return f"Rate {currency_code} to USD is: "+str(result["rates"][currency_code])

    

@app.route("/history/<fromdate>/<currency>") 
def history(fromdate: str, currency: str):
    try:
        date = datetime.strptime(fromdate, '%Y-%m-%d') 
    except ValueError:
        abort(404, description="Invalid date")

    if currency not in ['UAH', 'PLN', 'EUR', 'CAD']:
        abort(404, description="Invalid currency code")

    currency_code = db.session.query(Currency).filter_by(code=currency.upper()).first()

    rates = CurrencyRates.query.filter(CurrencyRates.date >= date, CurrencyRates.currency == currency_code).order_by(CurrencyRates.date.desc()).all()
    
    currency = currency.lower()
    pretty = "" 
    for rate in rates:
        pretty+="Date: "+str(rate.date)+" rate "+currency.upper()+" to USD: "+str(rate.rate)+"<br>"
    
    return pretty




if __name__ == "__main__":
    app.run(debug=True)