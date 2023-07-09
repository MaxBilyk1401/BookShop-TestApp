//
//  UITableViewCell+Extensions.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/9/23.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
}
