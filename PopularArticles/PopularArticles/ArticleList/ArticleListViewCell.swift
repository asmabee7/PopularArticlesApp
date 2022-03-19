//
//  ArticleListViewCell.swift
//  PopularArticles
//
//  Created by Asma Bee on 18/03/22.
//

import Foundation
import UIKit

class ArticleListViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var publishedDateLabel: UILabel!
    @IBOutlet var articleImageView: UIImageView!

    func configureCell(data: ArticleCellModel) {
        titleLabel.text = data.title ?? ""
        authorLabel.text = data.author
        publishedDateLabel.text = data.publishedDate
        
        if let imageURL = data.imageURL {
            articleImageView.isHidden = false
            articleImageView.getImage(imageURL)
        } else {
            articleImageView.isHidden = true
        }

    }
}
