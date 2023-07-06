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
        setupIconBook()
        setupNameLabel()
        setupAuthorLabel()
        setupPublisherLabel()
        setupDescriptionLabel()
        setupRankLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ model: BooksModel) {
        nameLabel.text = model.title
        authorLabel.text = model.author
        publisherLabel.text = model.publisher
        descriptionLabel.text = model.description
        rankLabel.text = String(model.rank)
        bookImage.setImage(with: model.bookImage)
    }
    
    private func setupIconBook() {
        bookImage = UIImageView()
        
        contentView.addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
        ])
    }
    
    private func setupNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
        ])
    }
    
    private func setupAuthorLabel() {
        authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 16, weight: .regular)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 0
        
        contentView.addSubview(authorLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupPublisherLabel() {
        publisherLabel = UILabel()
        publisherLabel.font = .systemFont(ofSize: 16, weight: .regular)
        publisherLabel.textColor = .black
        publisherLabel.numberOfLines = 0
        
        contentView.addSubview(publisherLabel)
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publisherLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            publisherLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupRankLabel() {
        rankLabel = UILabel()
        rankLabel.font = .systemFont(ofSize: 16, weight: .medium)
        rankLabel.textColor = .black
        rankLabel.numberOfLines = 0
        
        contentView.addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            rankLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            rankLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
        ])
    }
}
