//
//  RatesData.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import Foundation

struct RatesData: Codable {
    let table: String
    let effectiveDate: String
    let rates: [RateInfo]
}

struct RateInfo: Codable {
    let currency: String
    let code: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
}

struct RatesDataDates: Codable {
    let table: String
    let code: String
    let rates: [RateInfoDates]
}

struct RateInfoDates: Codable {
    let effectiveDate: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
}
