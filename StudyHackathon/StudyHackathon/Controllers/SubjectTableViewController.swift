//
//  SubjectTableViewController.swift
//  StudyHackathon
//
//  Created by Binjia Chen on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SubjectTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var subjects = [Subject]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureTableView()
        reloadSubjects()
    }
    
    @objc func reloadSubjects() {
        SubjectService.show { (subjects) in
            guard let subjectList = subjects else { return }
            
            self.viewWillAppear(false)
            
            self.subjects = subjectList
            
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        reloadSubjects()
    }
}

extension SubjectTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

extension SubjectTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SubjectTableViewCell.height
    }
}
