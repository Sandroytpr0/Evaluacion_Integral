//
//  Evaluacion_IntegralTests.swift
//  Evaluacion IntegralTests
//
//  Created by user293938 on 7/27/26.
//
//
//  MockProductRepository.swift
//  Evaluacion IntegralTests
//

import Foundation
@testable import Evaluacion_Integral

/// Repositorio falso que implementa el protocolo del Domain (ProductRepository).
/// Permite probar el ViewModel sin depender de la red real.
class MockProductRepository: ProductRepository {

    var productsToReturn: [Product] = []
    var errorToThrow: Error? = nil

    func getProducts() async throws -> [Product] {
        if let error = errorToThrow {
            throw error
        }
        return productsToReturn
    }
}

enum MockError: Error, LocalizedError {
    case network

    var errorDescription: String? {
        switch self {
        case .network:
            return "Fallo de red simulado"
        }
    }
}


