//
//  Endpoint.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest {
        return URLRequest(url: urlComponents.url!)
    }
}
