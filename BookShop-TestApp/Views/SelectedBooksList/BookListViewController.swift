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
    private var booksTableView: UITableView!
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
        setupTableView()
        bindOnViewModel()
        viewModel.fetchData()
        overrideUserInterfaceStyle = .dark
    }
    
    private func bindOnViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                booksTableView.refreshControl?.beginRefreshing()
            } else {
                booksTableView.refreshControl?.endRefreshing()
            }
        }
        
        viewModel.onLoadSuccess = { [weak self] list in
            guard let self else { return }
            self.list = list
            booksTableView.reloadData()
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
    
    private func setupTableView() {
        booksTableView = UITableView(frame: .zero)
        booksTableView.separatorStyle = .none
        
        let controll = UIRefreshControl()
        controll.addTarget(self, action: #selector(onBooksLoading), for: .valueChanged)
        booksTableView.refreshControl = controll
        
        booksTableView.dataSource = self
        booksTableView.delegate = self
        booksTableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        
        view.addSubview(booksTableView)
        booksTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            booksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            booksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            booksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func openURL(_ url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    @objc private func onBooksLoading() {
        viewModel.fetchData()
    }
}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        cell.setup(model)
        
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedURL = list[indexPath.row].buyURl
        openURL(selectedURL)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
