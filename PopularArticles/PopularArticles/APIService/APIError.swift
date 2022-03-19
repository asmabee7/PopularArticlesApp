//
//  APIError.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

typealias CodableError = Codable & LocalizedError

enum APIError: Error {
    case apiFailure(responseModel: CodableError)
    case noInternet
    case timeout
    case httpUnknownError(Error)
    case jsonParsingFail(Error)
    case httpResponseBodyNotFound
    case tokenExpired
}

extension APIError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case let .apiFailure(responseModel):
            return responseModel.localizedDescription
        case .noInternet:
            return "It appears that your network is down, please check and try again later"
        case .timeout:
            return "Your request has timed out, please try again"
        case .httpUnknownError, .jsonParsingFail, .httpResponseBodyNotFound:
            return "Something went wrong, please try again later"
        case .tokenExpired:
            return "Your token has expired, please login again"
        }
    }
}
