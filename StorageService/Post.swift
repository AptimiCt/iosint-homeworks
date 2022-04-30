//
//  Post.swift
//  Navigation
//
//  Created by Александр Востриков on 06.12.2021.
//

import Foundation

public struct Post {
    
    public init(author: String, description: String,
         image: String, likes: Int, views: Int){
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
    
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
}