//
//  CategoriesUIComposer.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import UIKit

enum CategoriesUIComposer {
    
    static func build(router: Router) -> UIViewController {
        let networkService = NetworkCategoriesService()
        let localService = CoreDataCategoriesService()
        let compositeService = LocalCategoriesServiceWithNetworkFallBack(localService: localService, networkService: networkService, localStorage: localService)
        return CategoriesViewController(router: router, viewModel: CategoriesViewModel(categoriesService: compositeService))
    }
}
