//
//  ViewController.swift
//  PopularArticles
//
//  Created by Asma Bee on 17/03/22.
//

import UIKit
import SafariServices
import Foundation

class ArticleListViewController: UIViewController {
    var articleListViewModel = ArticleListViewModel(networkManager: NetworkManager())
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = false
        self.title = "NY Times Popular Articles"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshData()
    }
    
    @objc func refreshData() {
        self.activityIndicator.startAnimating()
        articleListViewModel.getArticlesList { requestState in
            DispatchQueue.main.async {
                switch requestState {
                case .success:
                    self.activityIndicator.stopAnimating()
                    
                    self.refreshControl.endRefreshing()

                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                    self.errorMessageLabel.isHidden = true
                case .failed(let error):
                    self.errorMessageLabel.isHidden = false
                    self.tableView.isHidden = true
                    self.errorMessageLabel.text = error.localizedDescription
                    self.activityIndicator.stopAnimating()
                case .inProgress:
                    self.tableView.isHidden = true
                    self.activityIndicator.startAnimating()
                    self.errorMessageLabel.isHidden = true
                }
            }
        }
    }

}

extension ArticleListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        articleListViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleListViewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListViewCell", for: indexPath)
        if let articleCell = cell as? ArticleListViewCell {
            let cellModel = articleListViewModel.getArticleCellModel(at: indexPath)
            articleCell.configureCell(data: cellModel)
            return articleCell
        }
        return cell
    }
}


extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = articleListViewModel.articles[indexPath.row].url, let articleURL = URL(string: urlString) {
            let configuration = SFSafariViewController.Configuration()
            let detailsController = SFSafariViewController(url: articleURL, configuration: configuration)
            present(detailsController, animated: true, completion: nil)
        }
    }
}
