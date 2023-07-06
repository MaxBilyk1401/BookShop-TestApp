//
//  NetworkCategoriesService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import Foundation
import Alamofire

struct NetworkCategoriesService: CategoriesService {
    
    func loadData(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        AF.request("https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=8bGcfSPXwyGO8MAtAK6aPmXGaVmKZrzn").responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(NetworkCategoriesResponse.self, from: data)
                    let buissnesModel = result.results.map { CategoryModel(from: $0) }
                    completion(.success(buissnesModel))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension CategoryModel {
    init(from networkModel: NetworkCategoryModel) {
        self.displayName = networkModel.displayName
        self.listName = networkModel.listName
        self.newestPublishedDate = networkModel.newestPublishedDate
        self.oldestPublishedDate = networkModel.oldestPublishedDate
    }
}
