//
//  RatesManager.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import Foundation

protocol RatesManagerDelegate: AnyObject {
    func didUpdateRate(rateModel: RatesModel)
}

struct RatesManager {
    
    weak var delegate: RatesManagerDelegate?
    
    func fetchData(table: String) {
        if let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(table)/?format=json") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            
                            let result = try decoder.decode([RatesData].self, from: safeData)
                            
                            let rates = result[0].rates
                            let rateTable = result[0].table
                            let rateDate = result[0].effectiveDate
                            
                            let rate = RatesModel(table: rateTable, date: rateDate, rates: rates)
                            self.delegate?.didUpdateRate(rateModel: rate)
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
