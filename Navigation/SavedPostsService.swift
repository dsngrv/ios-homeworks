//
//  SavedPostsService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 17.01.2024.
//

import CoreData
import Foundation
import StorageService

final class SavedPostsService {
    
    static let shared = SavedPostsService()
    
    var savedPosts: [SavedPost] = []
    
    private init() {
        fetchPosts()
    }
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SavedPost")
        container.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    private lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchPosts() {
        let request = SavedPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        savedPosts = (try? context.fetch(request)) ?? []
    }
    
    func addPost(post: Post) {
        let newSavedPost = SavedPost.init(context: context)
        newSavedPost.author = post.author
        newSavedPost.descr = post.description
        newSavedPost.image = post.image
        newSavedPost.likes = Int32(post.likes)
        newSavedPost.views = Int32(post.views)
        savedPosts.append(newSavedPost)
    }

}
