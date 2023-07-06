//
//  CategoriesModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

struct CategoriesModel: Decodable {
    let listName, displayName, oldestPublishedDate: String
    let newestPublishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
    }
}
