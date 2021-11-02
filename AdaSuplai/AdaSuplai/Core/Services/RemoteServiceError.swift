//
//  RemoteServiceError.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 02/11/21.
//

import Foundation

enum RemoteServiceError: Error {
    case badURL
    case badServerResponse
    case badResponseID(status: Int)
}

extension RemoteServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("You have wrong url", comment: "")
        case .badServerResponse:
            return NSLocalizedString("No server response found", comment: "")
        case .badResponseID(let statusCode):
            return NSLocalizedString("Server Error \(statusCode)", comment: "")
        }
    }
}
