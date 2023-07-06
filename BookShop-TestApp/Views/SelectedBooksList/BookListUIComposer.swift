//
//  BookListUIComposer.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit

enum BookListUIComposer {

    static func build(router: Router, categoryName: String) -> UIViewController {
        let networkService = NetworkBooksService()
        let localService = CoreDataBooksService()
        let compositeService = LocalBooksServiceWithNetworkFallBack(localService: localService, networkService: networkService, localStorage: localService)
        
        return BookListViewController(router: router, viewModel: BooksViewModel(booksService: compositeService), categoryName: categoryName)
    }
}
