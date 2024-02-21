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
    var isFiltered: Bool = false
    
    private lazy var fetchResultController: NSFetchedResultsController<SavedPost> = {
        let request = SavedPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
        let fetchResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: SavedPostsService.shared.backgroundContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        return fetchResultsController
    }()
        
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
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? fetchResultController.performFetch()
    }
    
    @objc private func searchAction() {
        let alert = UIAlertController(title: "Search by author", message: "Enter author name", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Author name"
        }
        let findAction = UIAlertAction(title: "Find", style: .default) { [weak self] action in
            let author = alert.textFields?[0].text
            self?.fetchResultController.fetchRequest.predicate = NSPredicate(format: "author.name CONTAINS %@", author ?? "")
            try? self?.fetchResultController.performFetch()
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
            self?.fetchResultController.fetchRequest.predicate = nil
            try? self?.fetchResultController.performFetch()
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
            let savedPost = self.fetchResultController.object(at: indexPath)
            SavedPostsService.shared.delete(post: savedPost)
            try? self.fetchResultController.performFetch()
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
        fetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postsTableView.dequeueReusableCell(withIdentifier: SavedPostTableViewCell.identifier) as? SavedPostTableViewCell else { return UITableViewCell()}
        let savedPost = fetchResultController.object(at: indexPath)
        cell.setupCell(savedPost)
        return cell
    }
    
}

extension SavedPostsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        postsTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            postsTableView.insertRows(at: [newIndexPath!], with: .top)
        case .delete:
            postsTableView.deleteRows(at: [indexPath!], with: .middle)
        case .update:
            postsTableView.reloadRows(at: [indexPath!], with: .bottom)
        case .move:
            postsTableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            ()
        }
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        postsTableView.reloadData()
        postsTableView.endUpdates()
    }
    
}
