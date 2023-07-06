//
//  MService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Moya
import Foundation

enum LoadService {
    case categories
    case showBooks(categoryName: String)
}

extension LoadService: TargetType {
    var baseURL: URL { URL(string: "https://api.nytimes.com/svc/books/v3/lists")! }
    
    var path: String {
        switch self {
        case .categories:
            return "/names.json"
        case .showBooks(let categoryName):
            return "/current/\(categoryName).json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories, .showBooks:
            return .get
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api-key" : "8bGcfSPXwyGO8MAtAK6aPmXGaVmKZrzn"], encoding: URLEncoding.default)
    }
    
    var headers: [String: String]? {
        return nil
    }
}
