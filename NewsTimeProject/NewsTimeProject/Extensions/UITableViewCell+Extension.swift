//
//  UITableViewCell+Extension.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 12.05.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
