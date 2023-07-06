//
//  BookListViewController.swift
//  BookShop-TestApp
//
//  Created by Maxos on 7/6/23.
//

import UIKit

final class BookListViewController: UIViewController {
    private var list: [BooksModel] = []
    private var router: Router
    private var viewModel: BooksViewModel
    private var tableView: UITableView!
    private var titleLabel: UILabel!
    private var categoryName: String!
    
    init(router: Router, viewModel: BooksViewModel, categoryName: String) {
        self.router = router
        self.viewModel = viewModel
        self.categoryName = categoryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleLabel()
        setupTableView()
        bindOnViewModel()
        viewModel.fetchData(categoryName: categoryName)
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                tableView.refreshControl?.beginRefreshing()
            } else {
                tableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onRefresh = { [weak self] books in
            guard let self else { return }
            self.list = list
            tableView.reloadData()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Selected books"
        titleLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupTableView() {
        let controll = UIRefreshControl()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = controll
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier) as! BookTableViewCell
        cell.setup(list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
}

extension BookListViewController: UITableViewDelegate {
    
}
