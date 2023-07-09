//
//  CategoriesTableViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/9/23.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell {
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var dateImage: UIImageView!
    private var arrowImage: UIImageView!
    private var wrapView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: CategoryModel) {
        titleLabel.text = model.displayName
        dateLabel.text = model.newestPublishedDate
    }
    
    private func setupWrapView() {
        wrapView = UIView()
        wrapView.layer.cornerRadius = 16
        wrapView.layer.borderWidth = 0.40
        wrapView.layer.borderColor = UIColor(hexString: AllColors.whiteTransparentColor.name).cgColor
        wrapView.layer.cornerRadius = 16.0
        wrapView.layer.masksToBounds = true
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(wrapView)
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            wrapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            wrapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
        
        arrowImage = setupArrowImage()
        wrapView.addSubview(arrowImage)
        NSLayoutConstraint.activate([
            arrowImage.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -16),
        ])
        
        titleLabel = setupTitleLabel()
        wrapView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: 16)
        ])
        
        dateImage = setupDateImage()
        wrapView.addSubview(dateImage)
        NSLayoutConstraint.activate([
            dateImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateImage.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 16),
            dateImage.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -16),
            dateImage.heightAnchor.constraint(equalToConstant: 20),
            dateImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        dateLabel = setupDateLabel()
        wrapView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -16)
        ])
        
    }
    
    private func setupTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        titleLabel.numberOfLines = 2

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
    
    private func setupDateImage() -> UIImageView {
        let dateImage = UIImageView()
        dateImage.image = UIImage(named: AllImages.dateImage.name)
        
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        return dateImage
    }
    
    private func setupDateLabel() -> UILabel {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }
    
    private func setupArrowImage() -> UIImageView {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: AllImages.arrowImage.name)
        
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        return arrowImage
    }
    
    private func setupLayout() {
        layer.cornerRadius = 16
        backgroundColor = UIColor(hexString: AllColors.blackColor.name)
//        layer.borderWidth = 0.40
        layer.masksToBounds = false
    }

}
