//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Maryna Bolotska on 24/03/24.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdatePrice(model: CoinModelLocal)
    func didFailWithError(error: Error)
}

struct CoinManager {
    weak var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKeyAngela = "0feff4913ccdd32e8387da7076cbdf94"
    let newString = "http://api.coinlayer.com/api/live?access_key=0feff4913ccdd32e8387da7076cbdf94"
    let myApiKey = "362EE18C-44D4-44D4-BB9D-3F0B75F15511"
    let fullUrl = "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey="
  
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=362EE18C-44D4-44D4-BB9D-3F0B75F15511
//https://rest.coinapi.io/v1/exchangerate/BRL?apikey=362EE18C-44D4-44D4-BB9D-3F0B75F15511
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    //2
    mutating func getCoinPrice(currency: String) {
        let url = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=\(myApiKey)"
   
        performRequest(with: url)
       
    }
    
    //1
     func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(currencyData: safeData)
                    self.delegate?.didUpdatePrice(model: bitcoinPrice!)
                }
                
            }
            task.resume()
        }
        }
    
    
    func parseJSON(currencyData: Data) -> CoinModelLocal? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: currencyData)
             let price = decodedData.rate
            let transferredPrice = CoinModelLocal(rate: price)
            
            let currencyName = decodedData.asset_id_base
            let currencyUSD = decodedData.asset_id_quote
        //    let time = String(data: decodedData.time!, encoding: String.Encoding.utf8) as String?
            //no need to use currency, because I return Double(mistake), not CoinModel, as i need only rate
       //     let currency = CoinModel(asset_id_base: currencyName, asset_id_quote: currencyUSD, rate: price)

        //    return currency
          return transferredPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
