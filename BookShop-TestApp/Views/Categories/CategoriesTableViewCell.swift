//
//  CategoriesTableViewCell.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/3/23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    static let identifier = "Cell"
    private var title: UILabel!
    private var dateLabel: UILabel!
    private var dateIcon: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitle()
        setupDateIcon()
        setupDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupModel(_ model: CategoriesModel) {
        title.text = model.displayName
        dateLabel.text = model.newestPublishedDate
    }
    
    private func setupTitle() {
        title = UILabel()
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textColor = .black
        title.numberOfLines = 0
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
        ])
    }
    
    private func setupDateIcon() {
        dateIcon = UIImageView()
        dateIcon.image = UIImage(named: "date")
        
        contentView.addSubview(dateIcon)
        dateIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateIcon.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            dateIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateIcon.heightAnchor.constraint(equalToConstant: 16),
            dateIcon.widthAnchor.constraint(equalToConstant: 16)
            
        ])
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .black
        
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: dateIcon.trailingAnchor, constant: 8)
        ])
    }
}
