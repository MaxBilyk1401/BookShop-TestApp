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
    private var authorImage: UIImageView!
    private var publisherLabel: UILabel!
    private var publisherImage: UIImageView!
    private var descriptionLabel: UILabel!
    private var bookImage: UIImageView!
    private var buyButton: UIButton!
    private var authorStack: UIStackView!
    private var publisherStack: UIStackView!
    private var imageStack: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRankView()
        setupTitleLabel()
        authorAndPublisherLabel()
        setupDescriptionLabel()
        setupImageStack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(_ model: BooksModel) {
        rankLabel.text = "# \(model.rank)"
        titleLabel.text = model.title
        authorLabel.text = model.author
        publisherLabel.text = model.publisher
        descriptionLabel.text = model.description
        bookImage.setImage(with: model.bookImage)
    }
    
    private func setupRankView() {
        rectangleView = UIView()
        rankLabel = UILabel()
        rectangleView.backgroundColor = UIColor(hexString: AllColors.accentColor.name)
        
        contentView.addSubview(rectangleView)
        rectangleView.addSubview(rankLabel)
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
        ])
        
        rankLabel.font = .systemFont(ofSize: 16, weight: .medium)
        rankLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            rankLabel.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: rectangleView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func authorAndPublisherLabel() {
        authorStack = UIStackView()
        publisherStack = UIStackView()
        publisherImage = UIImageView()
        publisherLabel = UILabel()
        authorStack.axis = .horizontal
        authorStack.spacing = 4.0
        authorStack.distribution = .fillEqually
        authorImage = UIImageView()
        authorImage.contentMode = .scaleAspectFit
        authorImage.image = UIImage(named: AllImages.authorImage.name)
        authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 14, weight: .regular)
        authorLabel.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        contentView.addSubview(authorStack)
        authorStack.addArrangedSubview(authorImage)
        authorStack.addArrangedSubview(authorLabel)
        authorStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            authorStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorImage.widthAnchor.constraint(equalToConstant: 16),
            authorImage.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        publisherStack.axis = .horizontal
        publisherStack.spacing = 4.0
        publisherStack.distribution = .fillEqually
        publisherImage.contentMode = .scaleAspectFit
        publisherImage.image = UIImage(named: AllImages.publisherImage.name)
        publisherLabel.font = .systemFont(ofSize: 14, weight: .regular)
        publisherLabel.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        
        contentView.addSubview(publisherStack)
        publisherStack.addArrangedSubview(publisherImage)
        publisherStack.addArrangedSubview(publisherLabel)
        NSLayoutConstraint.activate([
            publisherStack.topAnchor.constraint(equalTo: authorStack.bottomAnchor, constant: 16),
            publisherStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            publisherImage.widthAnchor.constraint(equalToConstant: 16),
            publisherImage.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        descriptionLabel.numberOfLines = 0
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: publisherStack.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupImageStack() {
        imageStack = UIStackView()
        imageStack.axis = .vertical
        imageStack.spacing = 16.0
//        imageStack.distribution = .fillEqually
        bookImage = UIImageView()
        bookImage.contentMode = .scaleToFill
        buyButton = UIButton()
        
        contentView.addSubview(imageStack)
        imageStack.addArrangedSubview(bookImage)
        imageStack.addArrangedSubview(buyButton)
        imageStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageStack.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 16),
            imageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            imageStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            buyButton.widthAnchor.constraint(equalToConstant: 165),
            buyButton.heightAnchor.constraint(equalToConstant: 12),
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        
        let spacing: CGFloat = 8.0
        buyButton.setTitle(LocalizedStrings.details.localized, for: .normal)
        buyButton.tintColor = UIColor(hexString: AllColors.whiteColor.name)
        buyButton.backgroundColor = UIColor(hexString: AllColors.accentColor.name)
        buyButton.setImage(UIImage(named: AllImages.arrowImage.name), for: .normal)
        buyButton.semanticContentAttribute = .forceLeftToRight
        buyButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
        buyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing/2)
        buyButton.layer.cornerRadius = 16.0
    }
    
    private func setupLayout() {
        layer.cornerRadius = 16
        backgroundColor = UIColor(hexString: AllColors.accentColor.name)
        layer.masksToBounds = false
    }
}
