//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 17.05.2023.
//

import Foundation
import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    
    let filterImage = ImageProcessor()
    private var post: Post?
        
    private lazy var postHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postLikes: UILabel = {
        let likes = UILabel()
        likes.text = "Likes: "
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = UIColor.black
        likes.translatesAutoresizingMaskIntoConstraints = false
        return likes
    }()
    
    private lazy var postViews: UILabel = {
        let views = UILabel()
        views.text = "Views: "
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    private lazy var postLikesCounter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postViewsCounter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addToSaved() {
        SavedPostsService.shared.addPost(post: self.post!)
        SavedPostsService.shared.save()
        print("Saved")
    }
    
    private func setupGestures() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(addToSaved))
        postImage.isUserInteractionEnabled = true
        doubleTap.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(doubleTap)

    }
    
    func setupCell(_ post: Post) {
        postHeaderLabel.text = post.author
        postImage.image = UIImage(named: post.image)
        let images = postImage.image
        filterImage.processImage(sourceImage: images ?? UIImage(),
                                 filter: .posterize) { (image) in
            postImage.image = image
        }
        postDescription.text = post.description
        postLikesCounter.text = String(post.likes)
        postViewsCounter.text = String(post.views)
        self.post = post
    }
    
    private func setupLayout() {
        [postHeaderLabel, postImage, postDescription, postLikes, postLikesCounter, postViews, postViewsCounter].forEach({contentView.addSubview($0)})

        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        NSLayoutConstraint.activate([
            postHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImage.topAnchor.constraint(equalTo: postHeaderLabel.bottomAnchor, constant: 12),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: screenWidth),
            postImage.widthAnchor.constraint(equalToConstant: screenWidth),
            
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postLikesCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postLikesCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            postLikesCounter.leadingAnchor.constraint(equalTo: postLikes.trailingAnchor),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            postViews.trailingAnchor.constraint(equalTo: postViewsCounter.leadingAnchor),
            
            postViewsCounter.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            postViewsCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            postViewsCounter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

