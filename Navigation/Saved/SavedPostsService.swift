//
//  SavedPostsService.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 17.01.2024.
//

import CoreData
import Foundation
import StorageService

enum SavedError: Error {
    case alreadyInSaved
}

final class SavedPostsService {
    
    static let shared = SavedPostsService()
    
    var savedPosts: [SavedPost] = []
    
    private init() {
        fetchPosts()
    }
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SavedPost")
        container.loadPersistentStores { _, error in
            if let error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    func save() {
        do {
            try backgroundContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchPosts() {
        let request = SavedPost.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        savedPosts = (try? backgroundContext.fetch(request)) ?? []
    }
    
    func addPost(post: Post, completion: @escaping (Result<Any, SavedError>) -> Void) {
        guard !savedPosts.contains(where: {$0.uuid == post.id}) else {
            completion(.failure(.alreadyInSaved))
            return }
        
        let newSavedPost = SavedPost.init(context: backgroundContext)
        newSavedPost.author = post.author
        newSavedPost.descr = post.description
        newSavedPost.image = post.image
        newSavedPost.uuid = post.id
        savedPosts.append(newSavedPost)
        try? backgroundContext.save()
        completion(.success(true))
    }
    
    func delete(post: SavedPost) {
        let post = backgroundContext.object(with: post.objectID)
        backgroundContext.delete(post)
        try? backgroundContext.save()
    }

}
