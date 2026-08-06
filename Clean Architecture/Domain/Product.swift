//
//  Product.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import Foundation

struct Product: Identifiable, Codable, Sendable {
    let id: Int
    let name: String
    let brand: String
    let price: Double
    let rating: Double
    let image: String
    let description: String?
    let sizes: [String]?

  
}

