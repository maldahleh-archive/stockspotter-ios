//
//  StockClient.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

import Foundation

class StockClient: APIClient {
    let session = URLSession(configuration: .default)
    let jsonDecoder = JSONDecoder()
    
    typealias Industries = [String: Industry]
    typealias Industry = [Quote]
    
    typealias StockCompletionHandler = (Result<Industries, APIError>) -> Void
    
    func stocks(completion: @escaping StockCompletionHandler) {
        fetchWith(Stocks.all.request, decode: Industries.self, completion: completion)
    }
}
