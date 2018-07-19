//
//  Post.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    
    var isLiked = false
    
    //properties
    var likeCount: Int
    let poster: User
    
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        
        self.likeCount = 0
        self.poster = User.current
    }
    
    var dictValue: [String : Any] {
        let userDict = ["uid" : poster.uid,
                        "username" : poster.username]
        
        return ["image_url" : imageURL,
                "image_height" : imageHeight,
                "like_count" : likeCount,
                "poster" : userDict]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let imageURL = dict["image_url"] as? String,
            let imageHeight = dict["image_height"] as? CGFloat,
            
            let likeCount = dict["like_count"] as? Int,
            let userDict = dict["poster"] as? [String : Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        
        self.likeCount = likeCount
        self.poster = User(uid: uid, username: username)
    }
}
