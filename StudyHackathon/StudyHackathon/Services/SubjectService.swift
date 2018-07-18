//
//  SubjectService.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/18/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct SubjectService {
    static func show(completion: @escaping ([Subject]?) -> Void) {
        var subjects = [Subject]()
        
        let ref = Database.database().reference().child("subjects")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion(nil)
            }
            
            let dispatchGroup = DispatchGroup()
            
            for subjectSnap in snapshot {
                guard let subject = Subject(snapshot: subjectSnap) else { return }
                
                dispatchGroup.enter()
                
                subjects.append(subject)
                
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion(subjects)
            })
        })
    }
    
    static func create(subjectName: String) {
        let subjectRef = Database.database().reference().child("subjects").childByAutoId()
        let subjectKey = subjectRef.key
        
        Database.database().reference().child("subjects").child(subjectKey).setValue([
            "subjectName": subjectName,
            "posts": []]) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
        }
    }
}
