//
//  Quote.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

struct Quote: Decodable {
    let symbol: String
    let price: Double
    let change: Double
    let changePercent: Double
    let volume: Int
    let cap: Int
}
