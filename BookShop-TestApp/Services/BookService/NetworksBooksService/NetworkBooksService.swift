//
//  NetworkBooksService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation
import Moya

struct NetworkBooksService: BooksService {
#if DEBUG
    let provider = MoyaProvider<LoadService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
#else
    let provider = MoyaProvider<LoadService>()
#endif
    
    func loadData(categoryName: String, completion: @escaping (Result<[BooksModel], Error>) -> Void) {
        provider.request(.showBooks(categoryName: categoryName)) { response in
            switch response {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(NetworkBooksResponse.self, from: response.data)
                    let buissnesModel = result.results.books.map { model in BooksModel(from: model) }
                    completion(.success(buissnesModel))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension BooksModel {
    
    init(from networkBook: NetworkBookModel) {
        self.title = networkBook.title
        self.description = networkBook.description
        self.author = networkBook.author
        self.publisher = networkBook.publisher
        self.bookImage = networkBook.bookImage
        self.buyURl = networkBook.buyURl
        self.rank = networkBook.rank
    }
}
