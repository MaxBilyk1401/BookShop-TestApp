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
    var onLoading: ((Bool) -> Void)?
    var onRefresh: (([BooksModel]) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    init(booksService: BooksService) {
        self.booksService = booksService
    }
    
    func fetchData(categoryName: String) {
        onLoading?(true)
        onFailure?(nil)
        booksService.loadData(categoryName: categoryName) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.onRefresh?(success)
                    print(success)
                case .failure:
                    self.onFailure?("Oops, something went wrong!")
                }
                self.onLoading?(false)
            }
        }
    }
}
