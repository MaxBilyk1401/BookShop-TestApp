//
//  CategoriesString.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/7/23.
//

import Foundation

enum LocalizedStrings: String {
    case categoryLabel
    case bookLabel
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
