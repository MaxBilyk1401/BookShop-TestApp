//
//  UIImage+Extension.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/7/23.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        setImage(with: imageURL)
    }
    
    func setImage(with url: URL) {
        self.kf.setImage(
            with: .network(url),
            placeholder: nil,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ]
        )
    }
}

