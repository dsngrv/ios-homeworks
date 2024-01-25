//
//  SavedPostsViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 17.01.2024.
//

import CoreData
import Foundation
import StorageService
import UIKit

final class SavedPostsViewController: UIViewController {
    
    let coordinator: SavedPostsCoordinator
    private var posts: [SavedPost] = []
    var isFiltered: Bool = false
        
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SavedPostTableViewCell.self, forCellReuseIdentifier: SavedPostTableViewCell.identifier)
        return tableView
    }()
    
    init(coordinator: SavedPostsCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = SavedPostsService.shared.savedPosts
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        posts = SavedPostsService.shared.savedPosts
        postsTableView.reloadData()
    }
    
    @objc private func searchAction() {
        let alert = UIAlertController(title: "Search by author", message: "Enter author name", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Author name"
        }
        let findAction = UIAlertAction(title: "Find", style: .default) { [weak self] action in
            let author = alert.textFields?[0].text
            self?.posts = SavedPostsService.shared.filterByAuthor(author ?? "")
            self?.isFiltered = true
            self?.postsTableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(findAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc private func clearAction() {
        let alert = UIAlertController(title: "Filters clear", message: "List was reloaded", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.posts = SavedPostsService.shared.savedPosts
            self?.isFiltered = false
            self?.postsTableView.reloadData()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func addSearchBarButton() -> UIBarButtonItem {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAction))
        return searchButton
    }
    
    private func addClearFilterButton() -> UIBarButtonItem {
        let clearButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearAction))
        return clearButton
    }
    
    private func setupLayout() {
        view.addSubview(postsTableView)
        view.backgroundColor = .white
        navigationItem.title = "Saved Posts"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItems = [addSearchBarButton(), addClearFilterButton()]
        
        NSLayoutConstraint.activate([
            postsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension SavedPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            SavedPostsService.shared.delete(atIndex: indexPath.row)
            self.posts = SavedPostsService.shared.savedPosts
            self.postsTableView.reloadData()
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension SavedPostsViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postsTableView.dequeueReusableCell(withIdentifier: SavedPostTableViewCell.identifier) as? SavedPostTableViewCell else { return UITableViewCell()}
        cell.setupCell(posts[indexPath.row])
        return cell
    }
    
}
