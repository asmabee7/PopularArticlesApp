//
//  ArticleListViewModel.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation

class ArticleListViewModel {
    var articles: [Article] = []
    var numberOfSections: Int = 1
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    var requestState: RequestState = .inProgress

    func numberOfRowsIn(section: Int) -> Int {
        articles.count
    }

    func getArticlesList(completionHandler: @escaping (RequestState) -> ()) {
        networkManager.execute(request: ArticlesRequest(), responseType: ArticleResponse.self) { result in
            switch result {
            case .success(let model):
                self.articles = model.articles ?? []
                self.requestState = .success
            case .failure(let error):
                self.requestState = .failed(error)
            }
            completionHandler(self.requestState)
        }
    }
    
    func getArticleCellModel(at index: IndexPath) -> ArticleCellModel {
        return ArticleCellModel(article: self.articles[index.row])
    }
}

enum RequestState {
    case success
    case failed(Error)
    case inProgress
}
