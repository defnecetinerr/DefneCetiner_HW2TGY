//
//  LoadingShowable.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 12.05.2023.
//

import UIKit

protocol LoadingShowable where Self: UIViewController { // bunu sadece UIViewControllerlarda kullanabiliriz.
    func showLoading()
    func hideLoading()
    }

extension LoadingShowable {
    func showLoading() {
        LoadingView.shared.startLoading()
    }
    
    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
