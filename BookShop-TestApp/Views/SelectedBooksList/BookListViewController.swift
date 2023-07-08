//
//  BookListViewController.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit
import SafariServices

final class BookListViewController: UIViewController {
    private var list: [BooksModel] = []
    private var router: Router
    private var viewModel: BooksViewModel
    private var wrapView: UIView!
    private var appIcon: UIImageView!
    private var booksCollectionView: UICollectionView!
    private var titleLabel: UILabel!
    
    init(router: Router, viewModel: BooksViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
        setupTitleLabel()
        setupWrapView()
        setupCollectionView()
        bindOnViewModel()
        viewModel.fetchData()
        overrideUserInterfaceStyle = .dark
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                booksCollectionView.refreshControl?.beginRefreshing()
            } else {
                booksCollectionView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            booksCollectionView.reloadData()
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            let alert = UIAlertController(title: String(failure),
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: LocalizedStrings.OK.localized,
                                          style: .cancel))
            present(alert, animated: true)
        }
    }
    
    private func setupWrapView() {
        titleLabel = UILabel()
        appIcon = UIImageView()
        wrapView = UIView()
        wrapView.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
        
        view.addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 7.0),
            wrapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        appIcon.image = UIImage(named: AllImages.appIcon.name)
        appIcon.contentMode = .scaleAspectFit
        wrapView.addSubview(appIcon)
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appIcon.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 8),
            appIcon.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 16),
            appIcon.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 8),
            appIcon.heightAnchor.constraint(equalToConstant: 40),
            appIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        titleLabel.text = LocalizedStrings.categoryLabel.localized
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        wrapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 6)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = LocalizedStrings.bookLabel.localized
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.minimumInteritemSpacing = 16.0
        booksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onBooksLoading), for: .valueChanged)
        booksCollectionView.refreshControl = controll
        
        booksCollectionView.dataSource = self
        booksCollectionView.delegate = self
        booksCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)

        view.addSubview(booksCollectionView)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 16),
            booksCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            booksCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            booksCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func onBooksLoading() {
        viewModel.fetchData()
    }
}

extension BookListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
        cell.setup(list[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32)
        let height = width / 398 * 424
        return CGSize(width: width, height: height)
    }
}

extension BookListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedURl = list[indexPath.row].buyURl
                let safariViewController = SFSafariViewController(url: selectedURl)
                present(safariViewController, animated: true)
    }
}
