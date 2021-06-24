//
//  RatesManager.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import Foundation

protocol RatesManagerDelegate: AnyObject {
    func didUpdateFood(rateModel: RatesModel)
}


struct RatesManager {
    
    weak var delegate: RatesManagerDelegate?
    
    func fetchData() {
        if let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/a/?format=json") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode([RatesData].self, from: safeData)
                            
                            let rateTable = result[0].table
                            let rateNo = result[0].no
                            let rateDate = result[0].effectiveDate
                            let rates = result[0].rates
                            
                            let rate = RatesModel(table: rateTable, no: rateNo, date: rateDate, rates: rates)
                            self.delegate?.didUpdateFood(rateModel: rate)
                        
                        } catch {
                            print(error)
                            print("hrhrhrhrhhrrhhr")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    
}
