//
//  BookTableViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/9/23.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: BooksModel) {
        rankLabel.text = "#\(model.rank)"
        titleLabel.text = model.title
        authorLabel.text = model.author
        publisherLabel.text = model.publisher
        descriptionLabel.text = model.description
        bookImage.setImage(with: model.bookImage)
    }
    
    private func setupLayout() {
        let wrap = configureWrapView()
        contentView.addSubview(wrap)
        
        wrap.layer.cornerRadius = 16
        wrap.layer.masksToBounds = false
        wrap.layer.borderWidth = 0.25
        wrap.layer.borderColor = UIColor(hexString: AllColors.whiteTransparentColor.name).cgColor
        
        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            wrap.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            wrap.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            wrap.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0)
        ])
        
        let leftView = configureLeftView()
        wrap.addSubview(leftView)
        NSLayoutConstraint.activate([
            leftView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: 0.0),
            leftView.bottomAnchor.constraint(lessThanOrEqualTo: wrap.bottomAnchor, constant: 0.0),
            leftView.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: 0.0),
        ])
        
        let rightView = configureRightView()
        wrap.addSubview(rightView)
        
        NSLayoutConstraint.activate([
            rightView.topAnchor.constraint(equalTo: wrap.topAnchor, constant: 0.0),
            rightView.bottomAnchor.constraint(lessThanOrEqualTo: wrap.bottomAnchor),
            rightView.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: 0.0),
            rightView.heightAnchor.constraint(equalToConstant: 150.0),
            rightView.widthAnchor.constraint(equalToConstant: 165.0),
            rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 16.0)
        ])
    }
    
    private func configureLeftView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
                
        rankLabel = setupRankLabel()
        view.addSubview(rankLabel)
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            rankLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0)
        ])
        
        titleLabel = setupTitleLabel()
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
        
        authorImage = setupAuthorImage()
        authorLabel = setupAuthorLabel()
        view.addSubview(authorImage)
        view.addSubview(authorLabel)
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            authorLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 8.0),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            authorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            authorImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            authorImage.widthAnchor.constraint(equalToConstant: 20),
            authorImage.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        publisherLabel = setupPublisherLabel()
        publisherImage = setupPublisherImage()
        view.addSubview(publisherImage)
        view.addSubview(publisherLabel)
        NSLayoutConstraint.activate([
            publisherLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8.0),
            publisherLabel.leadingAnchor.constraint(equalTo: publisherImage.trailingAnchor, constant: 8.0),
            publisherImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8.0),
            publisherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            publisherImage.widthAnchor.constraint(equalToConstant: 20.0),
            publisherImage.heightAnchor.constraint(equalToConstant: 20.0),
        ])
        
        descriptionLabel = setupDescriptionLabel()
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 16.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0)
        ])
        return view
    }
    
    private func configureRightView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
        
        bookImage = setupBookImage()
        view.addSubview(bookImage)
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            bookImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            bookImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            bookImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4.0)
        ])
        
        return view
    }
    
    private func configureWrapView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
        return view
    }
    
    private func setupRankLabel() -> UILabel {
        let rankLabel = UILabel()
        rankLabel.layer.cornerRadius = 4.0
        rankLabel.clipsToBounds = true
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        rankLabel.numberOfLines = 0
        rankLabel.backgroundColor = UIColor(hexString: AllColors.accentColor.name)
        return rankLabel
    }
    
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(hexString: AllColors.whiteColor.name)
        return label
    }
    
    private func setupAuthorLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        return label
    }
    
    private func setupPublisherLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        return label
    }
    
    private func setupAuthorImage() -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: AllImages.authorImage.name)
        return image
    }
    
    private func setupPublisherImage() -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: AllImages.publisherImage.name)
        return image
    }
    
    private func setupDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: AllColors.whiteTransparentColor.name)
        label.numberOfLines = 0
        return label
    }
    
    private func setupBookImage() -> UIImageView {
        let image = UIImageView()
        image.layer.cornerRadius = 16.0
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }
    
    private func SetupCellView() {
        layer.cornerRadius = 16
        layer.masksToBounds = false
        layer.borderWidth = 0.25
        layer.borderColor = UIColor(hexString: AllColors.whiteTransparentColor.name).cgColor
    }
}
