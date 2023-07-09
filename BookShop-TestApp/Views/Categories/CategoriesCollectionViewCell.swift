//
//  CategoriesCollectionViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/8/23.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var dateImage: UIImageView!
    private var arrowImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupDateImage()
        setupDateLabel()
        setupArrowImage()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(_ model: CategoryModel) {
        titleLabel.text = model.displayName
        dateLabel.text = model.newestPublishedDate
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        titleLabel.numberOfLines = 0

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
    }
    
    private func setupDateImage() {
        dateImage = UIImageView()
        dateImage.image = UIImage(named: AllImages.dateImage.name)
        
        contentView.addSubview(dateImage)
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            dateImage.heightAnchor.constraint(equalToConstant: 20),
            dateImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupArrowImage() {
        arrowImage = UIImageView()
        arrowImage.image = UIImage(named: AllImages.arrowImage.name)
        
        contentView.addSubview(arrowImage)
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupLayout() {
        layer.cornerRadius = 16
        backgroundColor = UIColor(hexString: AllColors.blackColor.name)
        layer.borderWidth = 0.40
        layer.borderColor = UIColor(hexString: AllColors.whiteTransparentColor.name).cgColor
        layer.masksToBounds = false
    }
}
