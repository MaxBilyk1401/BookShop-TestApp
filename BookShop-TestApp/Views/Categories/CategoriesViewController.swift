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
    private var categoriesTableView: UITableView!
    
    init(router: Router, viewModel: CategoriesViewModel!) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: AllColors.mainColor.name)
        navigationController?.navigationBar.barStyle = .default
        view.backgroundColor = UIColor(hexString: AllColors.mainColor.name)
        setupCollectionVeiw()
        bindOnViewModel()
        setupNavigationBar()
        viewModel.fetchData()
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                categoriesTableView.refreshControl?.beginRefreshing()
            } else {
                categoriesTableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            categoriesTableView.reloadData()
        }
        
        viewModel.onFailure = { [weak self] failure in
            guard let self else { return }
            guard let failure else { return }
            let alert = UIAlertController(title: failure,
                                          message: nil,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "\(LocalizedStrings.OK.localized)",
                                          style: .cancel))
            present(alert, animated: true)
        }
    }
    
    private func setupNavigationBar() {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.title = "\(LocalizedStrings.categoryLabel.localized)"
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
            appIcon.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 8.0),
            appIcon.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 16.0),
            appIcon.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 8.0),
            appIcon.heightAnchor.constraint(equalToConstant: 40),
            appIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        titleLabel.text = LocalizedStrings.categoryLabel.localized
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = UIColor(hexString: AllColors.whiteColor.name)
        wrapView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 16.0),
            titleLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: 6.0)
        ])
    }
    
    private func setupCollectionVeiw() {
        categoriesTableView = UITableView(frame: .zero)
        categoriesTableView.separatorStyle = .none
        
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onCategoriesLoading), for: .valueChanged)
        
        categoriesTableView.estimatedRowHeight = UITableView.automaticDimension
        categoriesTableView.backgroundColor = UIColor(hexString: AllColors.blackColor.name)
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categoriesTableView.refreshControl = controll
        categoriesTableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        
        view.addSubview(categoriesTableView)
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func onCategoriesLoading() {
        viewModel.fetchData()
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as! CategoriesTableViewCell
        let item = list[indexPath.row]
        cell.setup(item)
        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = (list[indexPath.row].encodeName)
        router.showSelectedBooksList(categoryName: category)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
