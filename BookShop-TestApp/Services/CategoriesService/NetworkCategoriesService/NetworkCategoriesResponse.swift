//
//  NetworkCategoriesResponse.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import Foundation

struct NetworkCategoriesResponse: Decodable {
    let results: [NetworkCategoryModel]
}
