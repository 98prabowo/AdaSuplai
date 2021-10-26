//
//  LocalDataServices.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 25/10/21.
//

import Foundation
import UIKit

enum FetchError: Error {
    case badURL
    case badID
    case badData
}

class LocalDataServices {
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    /// Read local data.
    ///
    /// - Returns: Result of local data load in `Result` enum.
    func readLocalFile<T: Codable>(completion: @escaping (T) -> Void) {
        do {
            if let bundlePath = Bundle.main.path(forResource: self.fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
                completion(decodedData)
            }
        } catch {
            print("read local file error: \(error.localizedDescription)")
        }
    }
}
