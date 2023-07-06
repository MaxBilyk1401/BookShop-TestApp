//
//  CategoriesUIComposer.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import UIKit

enum CategoriesUIComposer {
    
    static func build(router: Router) -> UIViewController {
        return CategoriesViewController(router: router, viewModel: CategoriesViewModel(categoriesService: NetworkingManager()))
    }
}
