//
//  CategoriesModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import Foundation

struct CategoriesResponse: Decodable {
    let results: [CategoriesModel]
}

struct CategoriesModel: Decodable {
    let listName, displayName, oldestPublishedDate: String
    let newestPublishedDate: String
    let updated: Data
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case updated
    }
}

enum Data: String, Codable {
    case monthly = "MONTHLY"
    case weekly = "WEEKLY"
}
