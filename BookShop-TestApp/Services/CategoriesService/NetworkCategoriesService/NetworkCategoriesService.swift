//
//  NetworkCategoriesService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import Foundation
import Moya

struct NetworkCategoriesService: CategoriesService {
#if DEBUG
    let provider = MoyaProvider<MService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
#else
    let provider = MoyaProvider<MService>()
#endif
    
    func loadData(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        provider.request(.categories) { response in
            switch response {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(NetworkCategoriesResponse.self, from: response.data)
                    let buissnesModel = result.results.map { model in CategoryModel(from: model) }
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


