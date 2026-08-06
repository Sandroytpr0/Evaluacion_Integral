//
//  ProductAPIService.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import Foundation

struct ProductResponse: Codable,Sendable {
    let count: Int
    let results: [Product]
}


class ProductAPIService {
    
    func fetchProducts() async throws -> [Product] {
        
        guard let url = URL(string: "https://sneakerapi-y3ub.onrender.com/api/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return response.results
    }
}
