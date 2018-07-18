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
        
        self.tableView.reloadData()
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
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "postActionCell") as! PostActionCell
//
//            return cell

        default:
            fatalError("Error: unexpected indexPath")
        }
    }
}
