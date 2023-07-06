//
//  NetworkBooksResponse.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

struct NetworkBooksResponse: Decodable {
    
    struct NetworkFullCategoryModel: Decodable {
        let books: [NetworkBookModel]
    }
    
    let results: NetworkFullCategoryModel
}
