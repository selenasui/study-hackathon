//
//  PostViewController.swift
//  test-project
//
//  Created by Cindy Wang on 7/17/18.
//  Copyright © 2018 cxw. All rights reserved.
//

//get Date picker to fit and show correct time format
//need to add UIOutlet for End Time and make black border
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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    
    var locationPicker: UIPickerView?
    var classPicker: UIPickerView?
    
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBAction func chooseEndTime(_ sender: UIDatePicker) {
    }
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBAction func chooseStartTime(_ sender: UIDatePicker) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectLabel.text = subject?.subjectName
        
        let user = User.current
        self.usernameLabel.text = user.username

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
        
        //self.usernameLabel.text = post.poster.username
        
        locationPicker = createLocPicker()
        classPicker = createClassPicker()
        
        descriptionTextView.layer.cornerRadius = 15
        timeView.layer.cornerRadius = 5
    }
    
    let bioClasses = ["Bio 1A", "Bio 1B"]
    let chemClasses = ["Chem 1A", "Chem 1B", "Chem 3A", "Chem 3B", "Chem 4A", "Chem 4B"]
    let physicsClasses = ["Physics 8A", "Physics 8B", "Physics 7A", "Physics 7B"]
    
    let location = ["Moffit", "Doe", "VLSB", "Bancroft", "Haas", "Hildebrand",]
    let classes = ["Bio 1A", "Bio 1B", "Chem 1A", "Chem 1B", "Chem 3A", "Chem 3B", "Chem 4A", "Chem 4B", "Physics 8A", "Physics 8B", "Physics 7A", "Physics 7B"]
    
    var selectedLoc: String?
    var selectedClass: String?
    
    func createLocPicker() -> UIPickerView {
        
        let locPicker = UIPickerView()
        locPicker.delegate = self
        
        studyLocTextField.inputView = locPicker
        createToolbar(textField: studyLocTextField)
        //Customizations
        //LocPicker.backgroundColor = .white
        return locPicker
    }
    
    func createClassPicker() -> UIPickerView {
        
        let classPicker = UIPickerView()
        classPicker.delegate = self
        
        classTextField.inputView = classPicker
        createToolbar(textField: classTextField)
        return classPicker
    }
    
    func createToolbar(textField: UITextField) {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.backgroundColor = UIColor.blue
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self,
            action: #selector(PostViewController.dismissKeyboard))
            
        //doneButton.frame = CGRectMake(0, 0, 30, 30)
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        let leadingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let trailingFlex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [leadingFlex, doneButton, trailingFlex]
        textField.inputAccessoryView = toolBar

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
                else { return }
            
            PostService.create(location: location, course: course, description: description, subject: subject, startDate: startTimePicker.date, endDate: endTimePicker.date)
            
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
        if (pickView == locationPicker){
            return location.count
        }else{
            return classes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == locationPicker){
            return location[row]
        }else{
            return classes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == locationPicker){
            selectedLoc = location[row]
            studyLocTextField.text = selectedLoc
        }else{
            selectedClass = classes[row]
            classTextField.text = selectedClass
        }
    }
}
