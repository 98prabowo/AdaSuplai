//
//  Category.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 04/11/21.
//

import Foundation
import UIKit

// MARK: - InitialCategory
struct InitialCategory: Codable {
    let data: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id, name: String
    let v: Int
    let isHome: Bool?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case v = "__v"
        case isHome, image
    }
}

extension URLSession {
    func fetchDataCategory(at url: URL, completion: @escaping (Result<[Category], Error>) -> Void) {
        self.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let jsondata = try JSONDecoder().decode(InitialCategory.self, from: data)
                    let category = jsondata.data
                    completion(.success(category))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
