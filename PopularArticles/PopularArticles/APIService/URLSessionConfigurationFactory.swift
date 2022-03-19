//
//  URLSessionConfigurationFactory.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

final public class URLSessionConfigurationFactory {
    private static let defaultTimeout = TimeInterval(30)
    private static let defaultDiskCapacity = 20 * 1024 * 1024
    static let standardCache = URLCache(memoryCapacity: 16 * 1024 * 1024,
                                        diskCapacity: defaultDiskCapacity,
                                        diskPath: "default")
    
    static public func standard() -> URLSessionConfiguration {
        return createConfiguration(timeout: defaultTimeout,
                                   urlCache: standardCache,
                                   cachePolicy: .useProtocolCachePolicy)
    }
    
    private static func createConfiguration(timeout: TimeInterval,
                                            urlCache: URLCache,
                                            cachePolicy: NSURLRequest.CachePolicy) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = cachePolicy
        
        return configuration
    }
}
