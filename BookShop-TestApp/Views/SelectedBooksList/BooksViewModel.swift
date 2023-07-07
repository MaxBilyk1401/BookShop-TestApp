//
//  SelectedBookListViewModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation
import Alamofire

final class BooksViewModel {
    private let booksService: BooksService
    private let categoryName: String
    var onLoading: ((Bool) -> Void)?
    var onLoadSuccess: (([BooksModel]) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    init(booksService: BooksService, categoryName: String) {
        self.booksService = booksService
        self.categoryName = categoryName
    }
    
    func fetchData() {
        onLoading?(true)
        onFailure?(nil)
        booksService.loadData(categoryName: categoryName) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.onLoadSuccess?(success)
                    print(success)
                case .failure:
                    self.onFailure?("Oops, something went wrong!")
                }
                self.onLoading?(false)
            }
        }
    }
}
