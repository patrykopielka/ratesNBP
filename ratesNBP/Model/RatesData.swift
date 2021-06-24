//
//  RatesData.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import Foundation

struct RatesData: Codable {
    let table: String
    let no: String
    let effectiveDate: String
    let rates: [RateInfo]
}

struct RateInfo: Codable {
    let currency: String
    let code: String
    let mid: Float
}

