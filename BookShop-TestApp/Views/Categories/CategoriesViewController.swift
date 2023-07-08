//
//  ViewController.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/2/23.
//

import UIKit

final class CategoriesViewController: UIViewController {
    private var list: [CategoryModel] = []
    private var router: Router
    private var wrapView: UIView!
    private var appIcon: UIImageView!
    private var viewModel: CategoriesViewModel
    private var titleLabel: UILabel!
    private var categoriesCollectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    init(router: Router, viewModel: CategoriesViewModel!) {
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 16.0
        flow.minimumInteritemSpacing = 16.0
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: allColors.mainColor.name)
        setupWrapView()
        setupCollectionVeiw()
        bindOnViewModel()
        
        
        
        overrideUserInterfaceStyle = .light
        viewModel.fetchData()
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                categoriesCollectionView.refreshControl?.beginRefreshing()
            } else {
                categoriesCollectionView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            categoriesCollectionView.reloadData()
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            let alert = UIAlertController(title: String(failure),
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .cancel))
            present(alert, animated: true)
        }
    }
    
    private func setupWrapView() {
        titleLabel = UILabel()
        appIcon = UIImageView()
        wrapView = UIView()
        wrapView.backgroundColor = UIColor(hexString: allColors.mainColor.name)
        
        view.addSubview(wrapView)
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 7.0),
            wrapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        appIcon.image = UIImage(named: allImages.appIcon.name)
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
        titleLabel.textColor = UIColor(hexString: allColors.whiteColor.name)
        wrapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 6)
        ])
    }
    
    private func setupCollectionVeiw() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16.0
        flowLayout.scrollDirection = .vertical
        
        let controll = UIRefreshControl()
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        controll.addTarget(self, action: #selector(onCategoriesLoading), for: .valueChanged)
        
        categoriesCollectionView.backgroundColor = UIColor(hexString: allColors.blackColor.name)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.refreshControl = controll
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        view.addSubview(categoriesCollectionView)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func onCategoriesLoading() {
        viewModel.fetchData()
    }
}

//extension CategoriesViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let category = (list[indexPath.row].encodeName)
//        router.showSelectedBooksList(categoryName: category)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.setupModel(list[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32)
        let height = width / 398 * 86
        return CGSize(width: width, height: height)
    }
}

extension CategoriesViewController: UICollectionViewDelegate {

}
