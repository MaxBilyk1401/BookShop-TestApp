//
//  BookService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

protocol BooksService {
    func loadData(categoryName: String, completion: @escaping (Result<[BooksModel], Error>) -> Void)
}
