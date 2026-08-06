//
//  ProductAPIServiceTests.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/27/26.
//

//
//  ProductAPIServiceTests.swift
//  Evaluacion IntegralTests
//

import XCTest
@testable import Evaluacion_Integral

final class ProductAPIServiceTests: XCTestCase {

    func test_decodificacion_deJSON_delEndpoint_generaProductosValidos() throws {
        let json = """
        {
            "count": 1,
            "results": [
                {
                    "id": 1,
                    "name": "Air Jordan 1",
                    "brand": "Nike",
                    "price": 150.0,
                    "rating": 4.8,
                    "image": "https://example.com/img.png",
                    "description": "Clásicas y atemporales",
                    "sizes": ["8", "9", "10"]
                }
            ]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ProductResponse.self, from: json)

        XCTAssertEqual(response.count, 1)
        XCTAssertEqual(response.results.count, 1)
        XCTAssertEqual(response.results.first?.name, "Air Jordan 1")
        XCTAssertEqual(response.results.first?.price, 150.0)
    }

    func test_decodificacion_conCamposOpcionalesAusentes_noFalla() throws {
        let json = """
        {
            "count": 1,
            "results": [
                {
                    "id": 2,
                    "name": "Yeezy Boost 350",
                    "brand": "Adidas",
                    "price": 220.0,
                    "rating": 4.9,
                    "image": "https://example.com/img2.png"
                }
            ]
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(ProductResponse.self, from: json)

        XCTAssertNil(response.results.first?.description)
        XCTAssertNil(response.results.first?.sizes)
    }
}
