//
//  NetworkCategoryModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

struct NetworkCategoryModel: Decodable {
    let listName: String
    let displayName: String
//    let encodedName: String
    let oldestPublishedDate: String
    let newestPublishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
//        case encodedName = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
    }
}
