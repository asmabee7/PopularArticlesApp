//
//  JSONDecodingHandler.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

struct JSONDecodingHandler<T: CodableError> {
    func handle(response: HTTPURLResponse,
                data: Data,
                completionHandler: @escaping APICompletion<T>) {
        do {
            let decodedModel = try JSONDecoder().decode(T.self, from: data)
            switch response.statusCode {
            case 200 ... 299:
                completionHandler(.success(decodedModel))
            case 401, 403:
                completionHandler(.failure(.tokenExpired))
            default:
                completionHandler(.failure(.apiFailure(responseModel: decodedModel)))
            }
        } catch let jsonError {
            completionHandler(.failure(.jsonParsingFail(jsonError)))
        }
    }
}
