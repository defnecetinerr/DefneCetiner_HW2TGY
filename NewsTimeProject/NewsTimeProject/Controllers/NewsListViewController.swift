//
//  ViewController.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 11.05.2023.
//

import UIKit
import NewsAPI

final class NewsListViewController: UIViewController, LoadingShowable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let service: NewsServiceProtocol = NewsService()
    private var news: [News] = []
    private var media: [Multimedia] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchNews()
    }
    
    override func viewDidLoad() {
        tableView.register(.init(nibName: "NewsTimeTableViewCell", bundle: nil),forCellReuseIdentifier: "news")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
      private func fetchNews() {
        self.showLoading()
        service.fetchNews { [weak self] response in
            guard let self else { return }
            self.hideLoading()
            switch response {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
            case .failure(let error):
                let alertController = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath) as! NewsTimeTableViewCell
        let news = self.news[indexPath.row]
        cell.configure(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = news[indexPath.row]
        let newsTimeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "news") as! NewsDetailViewController
        newsTimeDetailsVC.selectedNews = selectedNews
        self.navigationController?.pushViewController(newsTimeDetailsVC, animated: true)
        
    }
}
