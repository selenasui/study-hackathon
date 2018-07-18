//
//  Subject.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Subject {
    
    let sid: String
    let subjectName: String
    
    init(sid: String, subjectName: String) {
        self.sid = sid
        self.subjectName = subjectName
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let subjectName = dict["subjectName"] as? String
            else { return nil }
        
        self.sid = snapshot.key
        self.subjectName = subjectName
    }
}
