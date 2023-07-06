//
//  CategoriesViewModel.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import Foundation

final class CategoriesViewModel {
    private let categoriesService: CategoriesService
    var onLoading: ((Bool) -> Void)?
    var onRefresh: (([CategoryModel]) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    init(categoriesService: CategoriesService) {
        self.categoriesService = categoriesService
    }
    
    func fetchData() {
        onLoading?(true)
        onFailure?(nil)
        categoriesService.loadData { [weak self] result in
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
