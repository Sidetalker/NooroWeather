//
//  NetworkService.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import UIKit

enum NetworkError: Error, Equatable {
    case invalidResponse(_ statusCode: Int)
    case badData
}

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(_ type: T.Type, from url: URL) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Codable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)
        
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            print(response)
            throw(NetworkError.invalidResponse(statusCode))
        }
        
        do {
            let jsonResponse = try JSONDecoder().decode(T.self, from: data)
            return jsonResponse
        } catch {
            throw NetworkError.badData
        }
    }
}
