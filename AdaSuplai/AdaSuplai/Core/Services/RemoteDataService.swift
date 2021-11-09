//
//  RemoteDataService.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/10/21.
//

import Foundation
import UIKit

class RemoteDataService {
    
    /// HTTP GET method to get data from remote directory. This method is call in async condition.
    ///
    /// - parameter url: An end-point url in `String` format.
    /// - returns: Data that have decoded to specific object/structure from remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error if any value throws an error during decoding.
    func getData<T: Codable>(_ type: T.Type, url: RemoteURL, keyword: String = "") async throws -> T {
        guard let url = URL(string: url.rawValue + keyword) else {
            throw RemoteServiceError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
    
    /// HTTP POST method to upload data from remote directory. This method is call in async condition.
    ///
    /// - parameters:
    ///   - url: An end-point url in `String` format.
    ///   - parameter: An object that will uploaded to remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error if any value throws an error during decoding.
    func postData<T: Codable>(url: RemoteURL, parameter: T) async throws {
        guard let url = URL(string: url.rawValue) else {
            throw RemoteServiceError.badURL }
        let jsonData = try JSONEncoder().encode(parameter)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.upload(for: request, from: jsonData)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        print(decodedData)
    }
    
    /// HTTP DELETE method to delete data from remote directory. This method is call in async condition.
    ///
    /// - parameters:
    ///   - url: An end-point url in `String` format.
    ///   - parameter: An object that will put in remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error if any value throws an error during decoding.
    func deleteData<T: Codable>(url: RemoteURL, parameter: T) async throws {
        guard let url = URL(string: url.rawValue) else {
            throw RemoteServiceError.badURL }
        let jsonData = try JSONEncoder().encode(parameter)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        print(decodedData)
    }
    
    /// HTTP PUT method to put data from remote directory. This method is call in async condition.
    ///
    /// - parameters:
    ///   - url: An end-point url in `String` format.
    ///   - parameter: An object that will put in remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error if any value throws an error during decoding.
    func putData<T: Codable>(url: RemoteURL, parameter: T) async throws {
        guard let url = URL(string: url.rawValue) else {
            throw RemoteServiceError.badURL }
        let jsonData = try JSONEncoder().encode(parameter)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        print(decodedData)
    }
    
    /// HTTP PATCH method to patch data from remote directory. This method is call in async condition.
    ///
    /// - parameters:
    ///   - url: An end-point url in `String` format.
    ///   - parameter: An object that will put in remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error if any value throws an error during decoding.
    func patchData<T: Codable>(url: RemoteURL, parameter: T) async throws {
        guard let url = URL(string: url.rawValue) else {
            throw RemoteServiceError.badURL }
        let jsonData = try JSONEncoder().encode(parameter)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        print(decodedData)
    }
    
    func downloadData(url: String) async throws -> Data {
        guard let url = URL(string: url) else { throw RemoteServiceError.badURL }
        let (localURL, response) = try await URLSession.shared.download(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else { throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        let data = try Data(contentsOf: localURL)
        return data
    }
    
    /// Upload image data to remote directory. This method is call in async condition.
    ///
    /// - parameters:
    ///   - url: An end-point url in `String` format.
    ///   - imageData: An image in `Data` format that will be uploaded to the remote directory.
    /// - throws: An error if url have wrong format or url is wrong.
    /// - throws: An error when server can't be reach for certains condition.
    /// - throws: An error when there are any error in `URLSession`.
    func postImage(url: RemoteURL, imageData: Data) async throws {
        guard let url = URL(string: url.rawValue) else {
            throw RemoteServiceError.badURL }
        let request = MultiPartFormDataRequest(url: url, method: .post)
        request.addDataField(named: "image", data: imageData, mimeType: "img/jpeg")
        let (data, response) = try await URLSession.shared.data(with: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RemoteServiceError.badServerResponse }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw RemoteServiceError.badResponseID(status: httpResponse.statusCode) }
        print(data)
    }
}
