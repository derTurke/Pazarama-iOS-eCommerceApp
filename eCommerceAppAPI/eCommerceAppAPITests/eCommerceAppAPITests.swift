//
//  eCommerceAppAPITests.swift
//  eCommerceAppAPITests
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import XCTest
@testable import eCommerceAppAPI
final class eCommerceAppAPITests: XCTestCase {
    
    func testProducts() throws {
        let bundle = Bundle(for: eCommerceAppAPITests.self)
        let url = bundle.url(forResource: "product", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let product = try JSONDecoder().decode(Products.self, from: data)
        XCTAssertEqual(product.id, 1, "Unexpected id.")
        XCTAssertEqual(product.title, "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", "Unexpected title.")
        XCTAssertEqual(product.price, 109.95, "Unexpected price.")
        XCTAssertEqual(product.description, "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", "Unexpected description.")
        XCTAssertEqual(product.category, "men's clothing", "Unexpected category.")
        XCTAssertEqual(product.image, "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", "Unexpected image.")
        XCTAssertEqual(product.rating!.rate, 3.9, "Unexpected rate item of rating.")
        XCTAssertEqual(product.rating!.count, 120, "Unexpected count item of rating.")
    }
}
