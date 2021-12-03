//
//  Extension-URLSession.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 02/11/21.
//

import Foundation

extension URLSession {
    
    /// Method to load data using an `MultiPartFormDataRequest`, creates and resumes an URLSessionDataTask internally.
    ///
    /// - Parameter request: The `MultiPartFormDataRequest` for which to load data.
    /// - Returns: Data and response.
    func data(with request: MultiPartFormDataRequest) async throws -> (Data, URLResponse) {
        let urlRequest = request.asURLRequest()
        return try await data(for: urlRequest)
    }
}
