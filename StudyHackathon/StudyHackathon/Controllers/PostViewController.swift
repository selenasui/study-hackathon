//
//  PostViewController.swift
//  test-project
//
//  Created by Cindy Wang on 7/17/18.
//  Copyright © 2018 cxw. All rights reserved.
//

//get Date picker to fit and show correct time format
//need to add UIOutlet for End Time and make black border
//need to get Loc Picker "Done" button working
//add second picker
//add pictures

    //Emily: add Color to nav bar and background
    //Selena: make "subject" and "username" specific

import UIKit
import FirebaseDatabase

class PostViewController: UIViewController {
    
    var subject: Subject?
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var studyLocTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    //@IBOutlet weak var datePicker: UIDatePicker!
    
    //@IBAction func setStartDate(_ sender: UIDatePicker) {
        //dateTimeTextField.text = "\(sender.date)"
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectLabel.text = subject?.subjectName

        self.descriptionTextView.layer.borderWidth = 2
//        self.descriptionTextView.clipsToBounds = true
//        self.descriptionTextView.layer.shadowRadius = 15
//        self.descriptionTextView.layer.shadowOpacity = 1
        self.descriptionTextView.layer.cornerRadius = 10
        self.descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        
        self.classTextField.layer.borderWidth = 1
        self.classTextField.layer.cornerRadius = 5
        self.classTextField.layer.borderColor = UIColor.gray.cgColor
        
        self.studyLocTextField.layer.borderWidth = 1
        self.studyLocTextField.layer.cornerRadius = 5
        self.studyLocTextField.layer.borderColor = UIColor.gray.cgColor
        
        self.dateTimeTextField.layer.borderWidth = 1
        self.dateTimeTextField.layer.cornerRadius = 5
        self.dateTimeTextField.layer.borderColor = UIColor.gray.cgColor
        
        //self.endTimeTextField.layer.borderWidth = 1
        //self.endTimeTextField.layer.borderColor = UIColor.gray.cgColor
        
        //self.usernameLabel.text = post.poster.username
        
        createLocPicker()
    }
    
    let bioClasses = ["Bio 1A", "Bio 1B"]
    let chemClasses = ["Chem 1A", "Chem 1B", "Chem 3A", "Chem 3B", "Chem 4A", "Chem 4B"]
    let physicsClasses = ["Physics 8A", "Physics 8B", "Physics 7A", "Physics 7B"]
    
    let location = ["Moffit", "Doe", "VLSB", "Bancroft", "Haas", "Hildebrand",]
    let classes = ["Bio 1A", "Bio 1B", "Chem 1A", "Chem 1B", "Chem 3A", "Chem 3B", "Chem 4A", "Chem 4B", "Physics 8A", "Physics 8B", "Physics 7A", "Physics 7B"]
    
    var selectedLoc: String?
    var selectedClass: String?
    
    func createLocPicker() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.tag = 1
        
        studyLocTextField.inputView = pickerView
        
        //Customizations
        //LocPicker.backgroundColor = .white
    }
    
    func createClassPicker() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.tag = 2
        
        classTextField.inputView = pickerView
    }
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self,
            action: #selector(PostViewController.dismissKeyboard))
            
        //doneButton.frame = CGRectMake(0, 0, 30, 30)
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        studyLocTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "post":
            guard let subject = subject,
                let location = studyLocTextField.text,
                let course = classTextField.text,
                let description = descriptionTextView.text
                //let startTime = dateTimeTextField.text,
                //let endTime = endTimeTextField.text
                else { return }
            
            PostService.create(location: location, course: course, description: description, subject: subject)
            
        case "cancel":
            print("cancel button tapped")
            
        default:
            print("Unexpected segue identifier")
        }
    }
}

extension PostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /*if (pickerView.tag == 1){
            return location.count
        }else{
            return classes.count
        }
        */
        return location.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        /*if (pickerView.tag == 1){
            return location[row]
        }else{
            return classes[row]
        }
        */
        return location[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        /*if (pickerView.tag == 1){
            selectedLoc = location[row]
            studyLocTextField.text = selectedLoc
        }else{
            selectedClass = classes[row]
            classTextField.text = selectedClass
        }
        */
        selectedLoc = location[row]
        studyLocTextField.text = selectedLoc
    }
}
