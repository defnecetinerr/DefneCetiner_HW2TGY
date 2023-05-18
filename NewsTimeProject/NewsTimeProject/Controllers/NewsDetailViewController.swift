//
//  NewsTimeDetailViewController.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 13.05.2023.
//

import UIKit
import NewsAPI
import SDWebImage
import SafariServices
import CoreData


final class NewsDetailViewController: UIViewController {
    
    @IBOutlet private weak var titleDetailLabel: UILabel!
    @IBOutlet private weak var largeImageView: UIImageView!
    @IBOutlet private weak var authorDetailLabel: UILabel!
    @IBOutlet private weak var abstractDetailLabel: UILabel!
    @IBOutlet private weak var categoriesDetailLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    var selectedNews: News?
    var newsDetail: News?
    var favoriteNews: NSManagedObject?
    var isFavorite = false
    @NSManaged public var url_fav: String?
    let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=kM36SrggFUFOtOXiBWtlBthxiHYiNF0R#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let selectedNews {
            titleDetailLabel.text = selectedNews.title
            authorDetailLabel.text = selectedNews.byline
            abstractDetailLabel.text = selectedNews.abstract
            categoriesDetailLabel.text = selectedNews.section
            
            if let media = selectedNews.multimedia?.first, let urlString = media.url, let url = URL(string: urlString) {
                largeImageView?.sd_setImage(with: url, placeholderImage: nil)
            }
        }
        if let favoriteNews {
            titleDetailLabel.text = favoriteNews.value(forKey: "title_fav") as? String
            abstractDetailLabel.text = favoriteNews.value(forKey: "description_fav") as? String
            authorDetailLabel.text = favoriteNews.value(forKey: "author_fav") as? String
            categoriesDetailLabel.text = favoriteNews.value(forKey: "categories_fv") as? String
            if let favoriteImageString = favoriteNews.value(forKey: "image_fav") as? String,
               let imageData = Data(base64Encoded: favoriteImageString),
               let image = UIImage(data: imageData) {
                largeImageView.image = image
            }
        }
    }
    
    @IBAction private func tappedSeeMoreButton(_ sender: Any) {
        if let urlString = selectedNews?.url {
            print("Selected News URL: \(urlString)")
            if let url = URL(string: urlString) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        } else if let favoriteNews = favoriteNews, let urlString = favoriteNews.value(forKey: "url_fav") as? String {
            print("Favorite News URL: \(urlString)")
            if let url = URL(string: urlString) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        } else {
            print("URL bilgisi bulunamadı")
        }
    }
    
    @IBAction private func tappedGoBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: Any) { 
        if isFavorite {
            likeButton.setImage(UIImage(systemName: "star"), for: .normal)
            isFavorite = false
        } else {
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFavorite = true
            let favoriteTitle = titleDetailLabel.text ?? ""
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<FavoritesDataModel> = FavoritesDataModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title_fav == %@", favoriteTitle)
            do {
                let results = try context.fetch(fetchRequest)
                if results.isEmpty {
                    let newFavorite = FavoritesDataModel(context: context)
                    newFavorite.id = UUID()
                    newFavorite.author_fav = authorDetailLabel.text
                    newFavorite.title_fav = titleDetailLabel.text
                    newFavorite.description_fav = abstractDetailLabel.text
                    newFavorite.categories_fv = categoriesDetailLabel.text
                    newFavorite.url_fav = selectedNews?.url
                    if let image = largeImageView.image, let imageData = image.jpegData(compressionQuality: 1.0) {
                        let base64String = imageData.base64EncodedString()
                        newFavorite.image_fav = base64String
                    }
                    try context.save()
                    print("Veri favorilere eklendi.")
                } else {
                    print("Bu haber zaten favorilere eklenmiş!")
                }
            } catch {
                print("Veri kaydedilirken hata oluştu: \(error)")
            }
        }
    }
}
