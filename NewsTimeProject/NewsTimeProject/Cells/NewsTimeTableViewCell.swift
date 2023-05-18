//
//  NewsTimeTableViewCell.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 12.05.2023.
//

import UIKit
import SDWebImage
import NewsAPI

final class NewsTimeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var titleTextLabel: UILabel! 
    @IBOutlet private weak var abstractLabel: UILabel!
    @IBOutlet private weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(news: News) {
        titleTextLabel?.text = news.title
        author?.text = news.byline
        categoryLabel?.text = news.section
        abstractLabel.text = news.abstract
        if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
            newsImage.sd_setImage(with: url, placeholderImage: nil)
        } else {
            newsImage.image = nil
        }
    }
}
