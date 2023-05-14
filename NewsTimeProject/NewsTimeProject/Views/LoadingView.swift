//
//  LoadingView.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 12.05.2023.
//

import UIKit

import UIKit

class LoadingView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView() // Çıkan Loading ikonuna activityIndicator deriz.
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center // ortaladık
        activityIndicator.hidesWhenStopped = true // durduğu an gizlensin
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        blurView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
