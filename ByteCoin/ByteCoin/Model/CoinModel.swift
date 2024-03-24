//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Maryna Bolotska on 24/03/24.
//

import Foundation
struct CoinModel: Codable {
    let time: Date?
    let asset_id_base: String?
    let asset_id_quote: String?
    let rate: String?
}
