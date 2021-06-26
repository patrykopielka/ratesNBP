//
//  RatesManagerDates.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 25/06/2021.
//

import Foundation

protocol RatesManagerDatesDelegate: AnyObject {
    func didUpdateRate(rateModel: RatesModelDates)
    func didFailWithError()
}


struct RatesManagerDates {
    
    weak var delegate: RatesManagerDatesDelegate?
    
    func fetchData(table: String, code: String, firstDate: String, secondDate: String) {
        if let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/\(table)/\(code)/\(firstDate)/\(secondDate)/?format=json") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(RatesDataDates.self, from: safeData)
                            
                            let rates = result.rates
                            let rateTable = result.table
                            let code = result.code
                            let rate = RatesModelDates(table: rateTable, code: code, rates: rates)
                            
                            self.delegate?.didUpdateRate(rateModel: rate)
                        } catch {
                            self.delegate?.didFailWithError()
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
