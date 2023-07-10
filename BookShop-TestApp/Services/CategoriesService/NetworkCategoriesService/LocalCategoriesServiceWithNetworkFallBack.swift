//
//  LocalCategoriesServiceWithNetworkFallBack.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation

final class LocalCategoriesServiceWithNetworkFallBack: CategoriesService {
    private let localService: CategoriesService
    private let networkService: CategoriesService
    private let localStorage: SaveCategorisService
    
    init(localService: CategoriesService, networkService: CategoriesService, localStorage: SaveCategorisService) {
        self.localService = localService
        self.networkService = networkService
        self.localStorage = localStorage
    }
    
    func loadData(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        localService.loadData { [weak self] localResult in
            guard let self else { return }
            
            switch localResult {
            case .success:
                completion(localResult)
                
            case .failure:
                self.networkService.loadData { networkResult in
                    
                    switch networkResult {
                    case .success(let categories):
                        self.saveIgnoringHandling(categories)
                        
                    case .failure:
                        break
                    }
                    completion(networkResult)
                }
            }
        }
    }
    
    func saveIgnoringHandling(_ categories: [CategoryModel]) {
        localStorage.save(categories, completion: { _ in })
    }
}
