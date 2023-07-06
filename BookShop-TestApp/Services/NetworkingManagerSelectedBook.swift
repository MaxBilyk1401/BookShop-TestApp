//
//  NetworkingManagerSelectedBook.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Foundation
import Alamofire

struct NetworkingManagerSelectedBook {
    
    func loadData(completion: @escaping (Result<[CategoriesModel], Error>) -> Void) {
        AF.request("https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=8bGcfSPXwyGO8MAtAK6aPmXGaVmKZrzn").responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
