//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Binjia Chen on 7/9/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    // MARK: - Subviews
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var createUsernameView: UIView!
    @IBOutlet weak var transparentView: UIView!
    
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nextButton.layer.cornerRadius = 20.0
        
        nextButton.layer.cornerRadius = 20.0
//        let gradient = CAGradientLayer()
//
//        gradient.frame = createUsernameView.bounds
        let darkCyan = UIColor(displayP3Red: 31.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
//        gradient.colors = [darkCyan.cgColor, UIColor.white.cgColor]
 transparentView.backgroundColor = darkCyan.withAlphaComponent(0.7)
//
//        createUsernameView.layer.insertSublayer(gradient, at: 0)

    }
    
    // MARK: - IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            User.setCurrent(user)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    
}
