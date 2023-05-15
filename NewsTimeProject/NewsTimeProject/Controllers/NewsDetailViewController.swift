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


class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var titleDetailLabel: UILabel!
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var authorDetailLabel: UILabel!
    @IBOutlet weak var abstractDetailLabel: UILabel!
    
    var selectedNews: News?
    let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=kM36SrggFUFOtOXiBWtlBthxiHYiNF0R#")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let news = selectedNews {
            titleDetailLabel.text = news.title
            authorDetailLabel.text = news.byline
            abstractDetailLabel.text = news.abstract
            
            if let media = news.multimedia?.first, let urlString = media.url, let url = URL(string: urlString){
                largeImageView?.sd_setImage(with: url, placeholderImage: nil)
            }
        }
    }
    
    @IBAction func seeMoreButton(_ sender: Any) {
        if let urlString = selectedNews?.url, let url = URL(string: urlString) {
               let safariViewController = SFSafariViewController(url: url)
               present(safariViewController, animated: true, completion: nil)
           }
        
    }
    
    
    @IBAction func goBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
