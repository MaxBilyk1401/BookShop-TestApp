//
//  ViewController.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/2/23.
//

import UIKit

final class MainViewController: UIViewController {
    private var list: [CategoriesModel] = []
    var viewModel: CategoriesViewModel!
    var titleLable: UILabel!
    var categoriesTableView: UITableView!
    
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
        titleLable = UILabel()
        titleLable.text = "Categories"
        titleLable.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLable.textColor = .black
        
        view.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
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
            categoriesTableView.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 16),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
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
