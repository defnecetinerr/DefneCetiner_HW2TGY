//
//  ViewController.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 11.05.2023.
//

import UIKit
import NewsAPI

class NewsListViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var tableView: UITableView!
    
    let service: NewsServiceProtocol = NewsService()
    private var news: [News] = []
    private var media: [Multimedia] = []
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchNews()
        
       }

    override func viewDidLoad() {
        tableView.register(.init(nibName: "NewsTimeTableViewCell", bundle: nil),forCellReuseIdentifier: "news")
    }
    fileprivate func fetchNews() {
        self.showLoading()
        service.fetchNews { [weak self] response in
            guard let self else { return }
            self.hideLoading()
            switch response {
            case .success(let news):
                self.news = news
                self.tableView.reloadData()
            case .failure(let error): break
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
