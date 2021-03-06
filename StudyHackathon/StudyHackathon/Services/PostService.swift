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
    static func create(location: String, course: String, description: String, subject: Subject, startDate: Date, endDate: Date) {
        let subject = subject
        let post = Post(location: location, course: course, description: description, startDate: startDate, endDate: endDate)
        
        let rootRef = Database.database().reference()
        let postRef = rootRef.child("subjects").child(subject.sid).child("posts").childByAutoId()
        let postKey = postRef.key
        
        let postDict = post.dictValue
        let updatedData: [String: Any] = ["subjects/\(subject.sid)/posts/\(postKey)": postDict]
        
        rootRef.updateChildValues(updatedData)
    }
    
    static func show(forKey postKey: String, subjectSID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("subjects").child(subjectSID).child("posts").child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(post)
        })
    }
}
