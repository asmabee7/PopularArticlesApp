//
//  ArticleCellModel.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

struct ArticleCellModel {
    var article: Article?
    init(article: Article) {
        self.article = article
    }
    var title: String? {
        return article?.title
    }
    var author: String? {
        return article?.author
    }
    var publishedDate: String? {
        return article?.publishedDate
    }
    var imageURL: String? {
        return article?.media?.first?.mediaMetaData?.first?.imageURL
    }
}
