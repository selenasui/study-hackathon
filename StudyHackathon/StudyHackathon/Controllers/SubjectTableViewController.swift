//
//  SubjectTableViewController.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SubjectTableViewController: UITableViewController {
    
//    var subjects = [Subject]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    var subjects = [Subject(sid: "a", subjectName: "Biology"),
                    Subject(sid: "b", subjectName: "Chemistry"),
                    Subject(sid: "c", subjectName: "Physics")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve subjects
        // notes = CoreDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectTableViewCell", for: indexPath) as! SubjectTableViewCell
        
        let subject = subjects[indexPath.row]
        cell.subjectNameLabel.text = subject.subjectName
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayChannel":
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let subject = subjects[indexPath.row]
            let destination = segue.destination as! ChannelViewController
            destination.subject = subject
        
        default:
            print("Unexpected segue identifier")
        }
    }
}
