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
    private static func create() {
        let currentUser = User.current
        let subject = Subject(sid: "a", subjectName: "Biology")
        let post = Post()
        
        let rootRef = Database.database().reference()
        let postRef = rootRef.child("subjects").child(subject.sid).child("posts").childByAutoId()
    }
}
