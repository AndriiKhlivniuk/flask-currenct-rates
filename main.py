import requests
from models import *
from datetime import datetime


key = "L2DHNuvK1jXaz8kXzZGvSsVnNVR25gmU"


@app.route("/allrates")
def all_rates():
    rates = CurrencyRates.query.order_by(CurrencyRates.date.desc())
    currency_rates_schema = CurrencyRatesSchema(many=True)
    result = currency_rates_schema.dump(rates)

    return result

@app.route("/history/<fromdate>/<currency>")
def history(fromdate: str, currency: str):
    date = datetime.strptime(fromdate, '%Y-%m-%d') 
    rates = CurrencyRates.query.filter(CurrencyRates.date >= date).order_by(CurrencyRates.date.desc()).all()
    currency_rates_schema = CurrencyRatesSchema(many=True)
    result = currency_rates_schema.dump(rates)
    
    currency = currency.lower()
    pretty = ""
    for rate in result:
        pretty+="Date: "+rate["date"]+" rate "+currency.upper()+" to USD: "+str(rate[currency])+"<br>"

    
    return pretty

@app.route("/actualrate/<currency_code>")
def def_exteral_rate(currency_code: str):
    
    currency_code = currency_code.upper()
    if currency_code!= 'UAH' or 'PLN' or 'EUR' or 'CAD':
        url = f"https://api.apilayer.com/exchangerates_data/latest?symbols={currency_code}%2C%20UAH%2C%20PLN%2C%20EUR%2C%20CAD&base=USD&base=USD"
    else:
        url = "https://api.apilayer.com/exchangerates_data/latest?symbols=UAH%2C%20PLN%2C%20EUR%2C%20CAD&base=USD"
        
    payload = {}
    headers= {
        "apikey": key
    }
    response = requests.request("GET", url, headers=headers, data = payload)
    status_code = response.status_code
    result = response.json()
    update_rates(result)


    return f"Rate {currency_code} to USD is: "+str(result["rates"][currency_code])



def update_rates(result):
    db.create_all()
    date = datetime.strptime(result["date"], '%Y-%m-%d') 
    
    
    most_recent_rates = CurrencyRates.query.order_by(CurrencyRates.date.desc()).first()

    if (most_recent_rates.date != date):
        if most_recent_rates.eur!=result["rates"]["EUR"] or most_recent_rates.cad!=result["rates"]["CAD"] or most_recent_rates.pln!=result["rates"]["PLN"] or most_recent_rates.uah!= result["rates"]["UAH"] :
            rates = CurrencyRates(
                                date=result["date"], eur=result["rates"]["EUR"], 
                                cad=result["rates"]["CAD"], pln=result["rates"]["PLN"],
                                uah=result["rates"]["UAH"] )

            db.session.add(rates)
            db.session.commit()



if __name__ == "__main__":
    app.run(debug=True)