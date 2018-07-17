//
//  PostViewController.swift
//  test-project
//
//  Created by Cindy Wang on 7/17/18.
//  Copyright © 2018 cxw. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
    }
    
}

