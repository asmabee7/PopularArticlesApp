//
//  ArticleDetailsViewController.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation
import UIKit

class ArticleDetailsViewController: UIViewController {
    var viewModel: ArticleDetailsViewModel!
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        let articleCellData = viewModel.getArticleData()
        if let imageURL = articleCellData.imageURL {
            articleImage.isHidden = false
            articleImage.getImage(imageURL)
        } else {
            articleImage.isHidden = true
        }
        titleLabel.text = articleCellData.title
        descriptionLabel.text = articleCellData.author
        
    }
    
}
