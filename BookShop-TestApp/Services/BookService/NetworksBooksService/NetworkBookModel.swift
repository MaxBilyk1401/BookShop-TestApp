//
//  NetworkBookModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

struct NetworkBookModel: Decodable {
    let title: String
    let description: String
    let author: String
    let publisher: String
    let bookImage: URL
    let buyURl: URL
    let rank: Int
    
    enum CodingKeys: String, CodingKey {
        case title, description, author, publisher, rank
        case bookImage = "book_image"
        case buyURl = "amazon_product_url" 
    }
}
