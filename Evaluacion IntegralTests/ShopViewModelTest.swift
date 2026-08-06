
//
//  ShopViewModelTest.swift
//  Evaluacion Integral
//
//  Created by user293938 on 7/27/26.
////
//  ShopViewModelTests.swift
//  Evaluacion IntegralTests
//

import XCTest
@testable import Evaluacion_Integral

@MainActor
final class ShopViewModelTests: XCTestCase {

    func test_fetchProducts_success_actualizaListaDeProductos() async {
        let mockRepository = MockProductRepository()
        mockRepository.productsToReturn = [
            Product(id: 1, name: "Air Jordan 1", brand: "Nike", price: 150.0,
                     rating: 4.8, image: "img1", description: "desc", sizes: ["8", "9"]),
            Product(id: 2, name: "Yeezy Boost 350", brand: "Adidas", price: 220.0,
                     rating: 4.9, image: "img2", description: "desc", sizes: ["7", "8"])
        ]
        let viewModel = ShopViewModel(repository: mockRepository)

        await viewModel.fetchProducts()

        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.first?.name, "Air Jordan 1")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_fetchProducts_error_defineMensajeDeErrorYListaVacia() async {
        let mockRepository = MockProductRepository()
        mockRepository.errorToThrow = MockError.network
        let viewModel = ShopViewModel(repository: mockRepository)

        await viewModel.fetchProducts()

        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_fetchProducts_alTerminar_isLoadingQuedaEnFalse() async {
        let mockRepository = MockProductRepository()
        mockRepository.productsToReturn = []
        let viewModel = ShopViewModel(repository: mockRepository)

        await viewModel.fetchProducts()

        XCTAssertFalse(viewModel.isLoading)
    }

    func test_toggleFavorite_agregaYQuitaProductoDeFavoritos() {
        let viewModel = ShopViewModel(repository: MockProductRepository())
        let product = Product(id: 1, name: "Air Jordan 1", brand: "Nike", price: 150.0,
                               rating: 4.8, image: "img1", description: "desc", sizes: ["8"])

        XCTAssertFalse(viewModel.isFavorite(product))
        viewModel.toggleFavorite(product)
        XCTAssertTrue(viewModel.isFavorite(product))
        viewModel.toggleFavorite(product)
        XCTAssertFalse(viewModel.isFavorite(product))
    }

    func test_addToCart_agregaProductoYCalculaTotalCorrecto() {
        let viewModel = ShopViewModel(repository: MockProductRepository())
        let product1 = Product(id: 1, name: "Air Jordan 1", brand: "Nike", price: 150.0,
                                rating: 4.8, image: "img1", description: "desc", sizes: ["8"])
        let product2 = Product(id: 2, name: "Yeezy Boost 350", brand: "Adidas", price: 220.0,
                                rating: 4.9, image: "img2", description: "desc", sizes: ["9"])

        viewModel.addToCart(product1)
        viewModel.addToCart(product2)

        XCTAssertEqual(viewModel.cart.count, 2)
        XCTAssertEqual(viewModel.cartTotal, 370.0, accuracy: 0.001)
    }

    func test_removeFromCart_eliminaElProductoCorrecto() {
        let viewModel = ShopViewModel(repository: MockProductRepository())
        let product = Product(id: 1, name: "Air Jordan 1", brand: "Nike", price: 150.0,
                               rating: 4.8, image: "img1", description: "desc", sizes: ["8"])

        viewModel.addToCart(product)
        XCTAssertEqual(viewModel.cart.count, 1)
        viewModel.removeFromCart(product)
        XCTAssertTrue(viewModel.cart.isEmpty)
    }
}
