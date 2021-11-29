//
//  ShipmentRatePagination.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 24/11/21.
//

import Foundation

struct ShipmentRatePagination: Codable {
    let currentPage, currentElements, totalPages, totalElements: Int
    let sortBy: [String]

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case currentElements = "current_elements"
        case totalPages = "total_pages"
        case totalElements = "total_elements"
        case sortBy = "sort_by"
    }
}
