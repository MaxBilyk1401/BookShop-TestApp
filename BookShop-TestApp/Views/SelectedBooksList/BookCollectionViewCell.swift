//
//  BookCollectionViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/8/23.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    private var rectangleView: UIView!
    private var rankLabel: UILabel!
    private var titleLabel: UILabel!
    private var authorLabel: UILabel!
    private var publisherLabel: UILabel!
    private var publisherImage: UIImageView!
    private var descreptionLabel: UILabel!
    private var bookImage: UIImageView!
    private var buyButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupRankView() {
        rectangleView = UIView()
        
        contentView.addSubview(rectangleView)
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        
        
        rankLabel = UILabel()
    }
}
