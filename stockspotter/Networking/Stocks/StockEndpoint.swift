//
//  StockEndpoint.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

import Foundation

enum Stocks {
    case all
}

extension Stocks: Endpoint {
    var base: String {
        return "http://localhost:8082"
    }
    
    var path: String {
        switch self {
        case .all:
            return "/"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .all:
            return nil
        }
    }
}
