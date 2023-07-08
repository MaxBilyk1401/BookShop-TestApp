//
//  allImages.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/8/23.
//

import Foundation

enum AllImages {
    case appIcon
    case dateImage
    case authorImage
    case publisherImage
    case arrowImage
    
    var name: String {
        switch self {
        case .appIcon:
            return "appIcon"
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
