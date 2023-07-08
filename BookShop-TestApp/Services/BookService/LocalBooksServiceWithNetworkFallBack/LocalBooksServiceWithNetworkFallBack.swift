//
//  LocalBooksServiceWithNetworkFallBack.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

final class LocalBooksServiceWithNetworkFallBack: BooksService {
    private let localService: BooksService
    private let networkService: BooksService
    private let localStorage: SaveBooksService
    
    init(localService: BooksService, networkService: BooksService, localStorage: SaveBooksService) {
        self.localService = localService
        self.networkService = networkService
        self.localStorage = localStorage
    }
    
    func loadData(categoryName: String, completion: @escaping (Result<[BooksModel], Error>) -> Void) {
        localService.loadData(categoryName: categoryName) { [weak self] localResult in
            guard let self else { return }
            
            switch localResult {
            case .success:
                completion(localResult)
                
            case .failure:
                self.networkService.loadData(categoryName: categoryName) { networkResult in
                    switch networkResult {
                    case .success(let books):
                        self.saveIgnoringHandling(books, categoryName: categoryName)
                        
                    case .failure:
                        break
                    }
                    
                    completion(networkResult)
                }
            }
        }
    }
    
    func saveIgnoringHandling(_ books: [BooksModel], categoryName: String) {
        localStorage.save(books, with: categoryName, completion: { _ in })
    }
}

