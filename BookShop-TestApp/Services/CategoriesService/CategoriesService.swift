//
//  CategoriesNetworkService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/4/23.
//

import Foundation

protocol CategoriesService {
    func loadData(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
}
