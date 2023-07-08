//
//  allColors.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/8/23.
//

import Foundation

enum allColors {
    case mainColor
    case blackColor
    case accentColor
    case whiteColor
    case whiteTransparentColor
    
    var name: String {
        switch self {
        case .mainColor:
            return "000C23"
        case .blackColor:
            return "020711"
        case .accentColor:
            return "60B7FF"
        case .whiteColor:
            return "FFFFFF"
        case .whiteTransparentColor:
            return "A3A3A3"
        }
    }
}
