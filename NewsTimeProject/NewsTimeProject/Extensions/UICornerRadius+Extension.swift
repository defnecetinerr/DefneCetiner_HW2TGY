//
//  UICornerRadius+Extension.swift
//  NewsTimeProject
//
//  Created by Defne Çetiner on 12.05.2023.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
