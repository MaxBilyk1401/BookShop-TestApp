//
//  ViewController.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/2/23.
//

import UIKit

final class CategoriesViewController: UIViewController {
    private var list: [CategoriesModel] = []
    private var router: Router
    private var viewModel: CategoriesViewModel
    private var titleLabel: UILabel!
    private var categoriesTableView: UITableView!
    
    init( router: Router, viewModel: CategoriesViewModel!) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleLable()
        setupTableVeiw()
        bindOnViewModel()
        
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
        
        viewModel.onRefresh = { [weak self] list in
            guard let self else { return }
            self.list = list
            categoriesTableView.reloadData()
        }
    }
    
    private func setupTitleLable() {
        titleLabel = UILabel()
        titleLabel.text = "Categories"
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupTableVeiw() {
        let controll = UIRefreshControl()
        categoriesTableView = UITableView()
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        categoriesTableView.refreshControl = controll
        categoriesTableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        
        view.addSubview(categoriesTableView)
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = (list[indexPath.row].displayName)
        
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier) as! CategoriesTableViewCell
        cell.setupModel(list[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}
