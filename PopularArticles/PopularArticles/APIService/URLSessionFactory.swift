//
//  URLSessionFactory.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

final class URLSessionFactory {
    private let configuration: URLSessionConfiguration
    private let isOnline: Bool

    init(configuration: URLSessionConfiguration, isOnline: Bool) {
        self.configuration = configuration
        self.isOnline = isOnline
    }

    func makeSession() -> URLSession {
        configuration.requestCachePolicy = isOnline ? .useProtocolCachePolicy : .returnCacheDataDontLoad
        return URLSession(configuration: configuration,
                          delegate: nil,
                          delegateQueue: nil)
    }
}
