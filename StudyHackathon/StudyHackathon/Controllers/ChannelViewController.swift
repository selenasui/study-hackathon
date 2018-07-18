//
//  ChannelViewController.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChannelViewController: UIViewController {
    
    var subject: Subject?
    var posts = [Post]()
    
    @IBOutlet weak var channelNavigationItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelNavigationItem.title = subject?.subjectName
        
        // manually create a new subject
//        SubjectService.create(subjectName: "")
        
        self.tableView.reloadData()
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        // notes = CoreDataHelper.retrieveSubjects()
    }
    
}

extension ChannelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell") as! PostHeaderCell
            //cell.usernameLabel.text = post.poster.username

            return cell

//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "postImageCell") as! PostImageCell
//
//            return cell
//
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell") as! PostActionCell
            // configure cell
            
            return cell

        default:
            fatalError("Error: unexpected indexPath")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "displayPost":
            guard let subject = self.subject else { return }
            let destination = segue.destination as! PostViewController
            destination.subject = subject
            
        default:
            print("Unexpected segue identifier")
        }
    }
}

extension ChannelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
            
        //case 1:
            // code for height of post description box
            
        case 2:
            return PostActionCell.height
        default:
            fatalError()
        }
    }
}
