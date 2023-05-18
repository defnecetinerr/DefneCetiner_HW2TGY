//
//  favoriteListCell.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 16.05.2023.
//

import UIKit
import NewsAPI

class favoriteListCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteAuthor: UILabel!
    @IBOutlet weak var sectionFavLabel: UILabel!
    @IBOutlet weak var titleFavLabel: UILabel!
    @IBOutlet weak var destriptionFavLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configure(news: FavoritesDataModel) {
        titleFavLabel.text = news.title_fav
        favoriteAuthor.text = news.author_fav
        destriptionFavLabel.text = news.description_fav
        sectionFavLabel.text = news.categories_fv
    }

}
