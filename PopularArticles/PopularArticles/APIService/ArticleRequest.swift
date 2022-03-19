//
//  ArticleRequest.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

struct ArticlesRequest: APIRequest {
    var baseURL: String =  "api.nytimes.com"
    
    var path: String {
        return "/svc/mostpopular/v2/viewed/7.json"
    }

    var method: HTTPMethod {
        return .get
    }

    var requestParameters: [URLQueryItem] {
        return [URLQueryItem(name: "api-key", value: "Oxd75GsHDbtpHsOBoIpLZmPrATvSQLEz")]
    }
}
