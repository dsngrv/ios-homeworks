//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий Снигирев on 05.04.2023.
//

import Foundation

public struct Post {
    public var author: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}

public var posts: [Post] = [
    Post(author: "Binance", description: "We are going to the moon!!!", image: "tothemoon", likes: 125, views: 250),
    Post(author: "Shibes World", description: "Welcome to our Shibelovers community", image: "shibes", likes: 500, views: 791),
    Post(author: "DogeMinerSim", description: "Download our DogeMiner Simulator! It's so fun!", image: "dogeminer", likes: 100, views: 678),
    Post(author: "Amazon", description: "Buy NOW! Doge T-shirt! SUCH WOW MUCH RETRO! Hurry Up!!!", image: "amazondoge", likes: 80, views: 263)
]
