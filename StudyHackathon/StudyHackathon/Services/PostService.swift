//
//  PostService.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/18/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct PostService {
    static func create(location: String, course: String, description: String, subject: Subject) {
        let subject = subject
        let post = Post(location: location, course: course, description: description)
        
        let rootRef = Database.database().reference()
        let postRef = rootRef.child("subjects").child(subject.sid).child("posts").childByAutoId()
        let postKey = postRef.key
        
        let postDict = post.dictValue
        let updatedData: [String: Any] = ["subjects/\(subject.sid)/posts/\(postKey)": postDict]
        
        rootRef.updateChildValues(updatedData)
    }
}
