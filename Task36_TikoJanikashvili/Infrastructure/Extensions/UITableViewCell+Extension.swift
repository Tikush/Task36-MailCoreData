//
//  UITableViewCell+Extension.swift
//  Task36_TikoJanikashvili
//
//  Created by Tiko on 18.06.21.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
