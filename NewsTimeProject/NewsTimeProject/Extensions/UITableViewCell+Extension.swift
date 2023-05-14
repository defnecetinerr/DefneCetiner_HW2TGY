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
        return String(describing: self) // dosyanın adı ne olduysa adı aynı olsun
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
