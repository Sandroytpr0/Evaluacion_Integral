//
//  ProductRepositoryImpl.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import Foundation

class ProductRepositoryImpl: ProductRepository {
    private let apiService: ProductAPIService

    init(apiService: ProductAPIService = ProductAPIService()) {
        self.apiService = apiService
    }

    func getProducts() async throws -> [Product] {
        return try await apiService.fetchProducts()
    }
}
