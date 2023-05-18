//
//  FavoriteNewsViewController.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 16.05.2023.
//

import UIKit
import CoreData
import NewsAPI
import Foundation

final class FavoriteNewsViewController: UIViewController {
    
    @IBOutlet private weak var favoriteListTableView: UITableView!
    
    private var favoriteNewsList: [FavoritesDataModel] = []
    
    override func viewDidLoad() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<FavoritesDataModel> = FavoritesDataModel.fetchRequest()
        
        do {
            favoriteNewsList = try context.fetch(request)
            print(favoriteNewsList)
            favoriteListTableView.reloadData()
        } catch {
            print(error)
        }
    }
}

extension FavoriteNewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! favoriteListCell
        let favoriteNews = favoriteNewsList[indexPath.row]
        cell.configure(news: favoriteNews)
        if let favoriteImageString = favoriteNews.value(forKey: "image_fav") as? String,
           let _ = Data(base64Encoded: favoriteImageString),
           let imageData = Data(base64Encoded: favoriteImageString),
           let image = UIImage(data: imageData) {
            
            cell.favoriteImage.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteNews = favoriteNewsList[indexPath.row]
        if let newsDetailViewController = storyboard?.instantiateViewController(withIdentifier: "news") as? NewsDetailViewController {
            newsDetailViewController.favoriteNews = favoriteNews
            navigationController?.pushViewController(newsDetailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteNews = favoriteNewsList[indexPath.row]
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            context.delete(favoriteNews)
            do {
                try context.save()
                fetchData()
            } catch {
                print(error)
            }
        }
    }
}



