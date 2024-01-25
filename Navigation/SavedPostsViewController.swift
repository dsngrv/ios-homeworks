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
    
    private func setupLayout() {
        view.addSubview(postsTableView)
        view.backgroundColor = .white
        navigationItem.title = "Saved Posts"
        navigationController?.navigationBar.backgroundColor = .white
        
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
