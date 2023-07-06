//
//  MService.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import Moya
import Foundation

enum MService {
    case categories
    case showBooks(path: String)
}

extension MService: TargetType {
    var baseURL: URL { URL(string: "https://api.nytimes.com/svc/books/v3/lists")! }
    
    var path: String {
        switch self {
        case .categories:
            return "/names.json"
        case .showBooks(let path):
            return "/names/\(path).json"
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
