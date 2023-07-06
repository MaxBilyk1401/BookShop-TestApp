//
//  CategoriesString.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/7/23.
//

import Foundation

enum CategoriesString: String {
    case categoryLabel
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
