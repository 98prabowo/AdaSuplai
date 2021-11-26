//
//  Product.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 04/11/21.
//

import Foundation

struct Product: Codable {
    let fiveStarRating, fourStarRating, threeStarRating, twoStarRating: StarRating
    let oneStarRating: StarRating
    let id: String
    let supplier: Supplier
    let category: Category
    let etalase, name, description, status: String
    let dimension: String
    let minOrder, neto, bruto, price: Int
    let stock: Int
    let unit, image: String
    let v: Int
    let brand: Brand
    let sales, numReviews: Int
    let rating: Double
    let reviews: [Review]
    let length, width, height: Int

    enum CodingKeys: String, CodingKey {
        case fiveStarRating, fourStarRating, threeStarRating, twoStarRating, oneStarRating
        case id = "_id"
        case supplier = "supplier_id"
        case category = "category_id"
        case etalase = "etalase_id"
        case name
        case description
        case status, dimension
        case minOrder = "min_order"
        case neto, bruto, price, stock, unit, image
        case v = "__v"
        case brand = "brand_id"
        case sales, numReviews, rating, reviews, length, width, height
    }
}

struct StarRating: Codable {
    let ammount: Int?
    let ratings: [Review]
}

struct Review: Codable {
    let name: String
    let profilePicture: String?
    let rating: Double
    let comment, user, image, id: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case name, profilePicture, rating, comment, user, image
        case id = "_id"
        case createdAt, updatedAt
    }
}
