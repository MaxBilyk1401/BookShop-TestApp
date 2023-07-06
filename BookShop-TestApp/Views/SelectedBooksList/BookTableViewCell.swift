//
//  BookTableViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
    static let identifier = "Cell"
    
    private var nameLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var authorLabel: UILabel!
    private var publisherLabel: UILabel!
    private var bookImage: UIImageView!
    private var rankLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
