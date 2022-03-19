//
//  APIRequest.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

protocol APIRequest {
    var baseURL: String { set get }
    var path: String { get }
    var requestParameters: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.host = baseURL
        components.path = path
        components.scheme = "https"
        components.queryItems = requestParameters
        
        guard let url = components.url else {
            fatalError("URL Request building error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPContentType: String {
    case applicationJson = "application/json"
    case formUrlEncoded = "application/x-www-form-urlencoded"
}
