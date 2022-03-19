//
//  NetworkManager.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation
typealias APICompletion<T> = (Result<T, APIError>) -> ()

protocol APIService {
    func execute<T: CodableError>(request: APIRequest,
                                    responseType: T.Type,
                                    completionHandler: @escaping APICompletion<T>)
}

class NetworkManager: APIService {
    private let urlSessionFactory: URLSessionFactory

    init(configuration: URLSessionConfiguration = URLSessionConfigurationFactory.standard()) {
        self.urlSessionFactory = URLSessionFactory(configuration: configuration, isOnline: true)
    }

    func execute<T: CodableError>(request: APIRequest,
                                    responseType: T.Type,
                                    completionHandler: @escaping APICompletion<T>) {
        let urlRequest = request.urlRequest

        let dataTask = urlSessionFactory
            .makeSession()
            .dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    if error._domain == NSURLErrorDomain, error._code == NSURLErrorTimedOut {
                        completionHandler(.failure(.timeout))
                    } else {
                        completionHandler(.failure(.httpUnknownError(error)))
                    }
                } else {
                    if let httpResponse = response as? HTTPURLResponse, let data = data {
                        JSONDecodingHandler().handle(response: httpResponse,
                                                     data: data,
                                                     completionHandler: completionHandler)
                    } else {
                        completionHandler(.failure(.httpResponseBodyNotFound))
                    }
                }
            }
        dataTask.resume()
    }
}

