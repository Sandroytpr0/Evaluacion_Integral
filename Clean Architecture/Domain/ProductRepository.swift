//
//  ProductRepository.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/25/26.
//

import Foundation

protocol ProductRepository {
    func getProducts() async throws -> [Product]
}
