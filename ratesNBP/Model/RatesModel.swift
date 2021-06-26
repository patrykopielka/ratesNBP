//
//  RatesModel.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import Foundation


struct RatesModel {
    let table: String
    let date: String
    let rates: [RateInfo]
}

struct RatesModelDates {
    let table: String
    let code: String
    let rates: [RateInfoDates]
}
