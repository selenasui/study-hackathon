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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
       // case "save":
            // save post to database
            
        case "cancel":
            print("cancel bar button item pressed")
            
        default:
            print("Unexpected segue identifier")
        }
    }
    
}
