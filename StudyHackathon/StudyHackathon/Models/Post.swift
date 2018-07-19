//
//  Post.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    
    var key: String?
    let location: String
    let course: String
    let description: String
    let poster: User
    var likeCount: Int
    
    init(location: String, course: String, description: String) {
        self.location = location
        self.course = course
        self.description = description
        
        self.poster = User.current
        self.likeCount = 0
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let location = dict["location"] as? String,
            let course = dict["course"] as? String,
            let description = dict["description"] as? String,
            let likeCount = dict["like_count"] as? Int,
        
            let userDict = dict["poster"] as? [String: Any],
            let uid = userDict["uid"] as? String,
            let username = userDict["username"] as? String
            else { return nil }
        
        self.key = snapshot.key
        self.location = location
        self.course = course
        self.description = description
        self.likeCount = likeCount
        
        self.poster = User(uid: uid, username: username)
    }
    
    var dictValue: [String : Any] {
        let userDict = ["uid" : poster.uid,
                        "username" : poster.username]
        
        return ["location" : location,
                "course" : course,
                "description" : description,
                "poster" : userDict,
                "like_count" : likeCount]
    }
    
    var isLiked = false
}
