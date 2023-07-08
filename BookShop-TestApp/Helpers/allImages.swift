//
//  allImages.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/8/23.
//

import Foundation

enum allImages {
    case dateImage
    case authorImage
    case publisherImage
    case arrowImage
    
    var name: String {
        switch self {
        case .dateImage:
            return "date"
        case .authorImage:
            return "author"
        case .publisherImage:
            return "publisher"
        case .arrowImage:
            return "arrow"
        }
    }
}
