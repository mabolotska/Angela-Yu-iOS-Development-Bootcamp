//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Maryna Bolotska on 24/03/24.
//

import Foundation

struct CoinModelLocal {
    let rate: Double?
}

struct CoinModel: Codable {
//    let time: Date?
    let asset_id_base: String?
    let asset_id_quote: String?
    let rate: Double?
    
}
struct ArrayCoinModel: Codable {
    let arrayModel: [CoinModel]
}


// MARK: - Array
//struct ArrayCoinModel: Codable {
//    let assetIDBase: String?
//    let rates: [Rate]?
//
//    enum CodingKeys: String, CodingKey {
//        case assetIDBase = "asset_id_base"
//        case rates
//    }
//}

//// MARK: - Rate
//struct Rate: Codable {
//    let time, assetIDQuote: String?
//    let rate: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case time
//        case assetIDQuote = "asset_id_quote"
//        case rate
//    }
//}
