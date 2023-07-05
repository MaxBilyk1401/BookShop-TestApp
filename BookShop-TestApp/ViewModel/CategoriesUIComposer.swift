//
//  CategoriesUIComposer.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import UIKit

enum CategoriesUIComposer {
    
    static func build() -> UIViewController {
        let vc = MainViewController()
        let viewModel = CategoriesViewModel(categoriesService: NetworkingManager())
        vc.viewModel = viewModel
        
        return vc
    }
}
