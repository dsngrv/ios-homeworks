//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 07.04.2023.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    private var listPhoto = Photo.makePhotoCollection()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(
            frame: .zero,
            style: .grouped
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            view.backgroundColor = .lightGray
        #else
        view.backgroundColor = .darkGray
        #endif
        
        navigationController?.navigationBar.isHidden = true
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
    
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        header.backgroundColor = .clear
        return section == 0 ? header : nil
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 222 : 0
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // здесь ошибка
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier) as? PhotosTableViewCell else { return UITableViewCell()}

            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else { return UITableViewCell()}
            cell.setupCell(posts[indexPath.row])
            return cell
        }
    }
}
extension UIView {

    static var identifier: String {return String(describing: self)}
    
}

extension ProfileViewController: PhotosGalleryDelegate {
    func openGallery() {
        let gallery = PhotosViewController()
        navigationController?.pushViewController(gallery, animated: true)
    }
}
