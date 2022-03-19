//
//  Article.swift
//  PopularArticles
//
//  Created by Asma Bee on 17/03/22.
//

import Foundation

struct ArticleResponse: Codable, LocalizedError {
    var copyright: String?
    var numOfResults: Int?
    var articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case copyright
        case numOfResults = "num_results"
        case articles = "results"
    }
}

struct Article: Codable {
    var url: String?
    var title: String?
    var author: String?
    var publishedDate: String?
    var media: [ArticleMedia]?

    enum CodingKeys: String, CodingKey {
        case url
        case title
        case author = "byline"
        case publishedDate = "published_date"
        case media
    }
}

struct ArticleMedia: Codable {
    var mediaMetaData: [ArticleMediaData]?
    enum CodingKeys: String, CodingKey {
        case mediaMetaData = "media-metadata"
    }
}

struct ArticleMediaData: Codable {
    var imageURL: String?
    var width: Int?
    var height: Int?

    enum CodingKeys: String, CodingKey {
        case imageURL = "url"
        case width
        case height
    }
}

