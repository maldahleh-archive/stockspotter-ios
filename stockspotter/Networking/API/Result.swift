//
//  Result.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//


enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
