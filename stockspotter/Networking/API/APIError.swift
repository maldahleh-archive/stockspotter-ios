//
//  APIError.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

enum APIError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonConversionFailure
}
