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
    case details
    case OK
    case back
    case failure
    
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
