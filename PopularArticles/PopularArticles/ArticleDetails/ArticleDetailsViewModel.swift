//
//  ArticleDetailsViewModel.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

class ArticleDetailsViewModel {
    var article: ArticleCellModel!
    
    init(article: ArticleCellModel) {
        self.article = article
    }
    
    func getArticleData() -> ArticleCellModel {
        return article
    }
}
