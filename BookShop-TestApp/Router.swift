//
//  Router.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit

final class Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func showCategoriesScreenAsRootController() {
        navigationController?.setViewControllers([CategoriesUIComposer.build(router: self)], animated: true)
    }
    
    func showSelectedBooksList(categoryName: String) {
        navigationController?.pushViewController(BookListUIComposer.build(router: self, categoryName: categoryName), animated: true)
    }
}
