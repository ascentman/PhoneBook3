//
//  ContactViewController.swift
//  PhoneBook3
//
//  Created by Vova on 8/29/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

enum ContactViewControllerStates {
    case add
    case show
}

final class ContactViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let manager = FileManagerClass()
    var newContact = Contact()
    var currentState : ContactViewControllerStates = .add

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if currentState == .show {
            saveButton.isHidden = true
            name.isHidden = true
            surname.isHidden = true
            self.title = "Details"
        }
        
        nameLabel.text = newContact.name
        surnameLabel.text = newContact.surname
        //img
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        guard let cName = name.text,
            !cName.isEmpty,
            let cSurname = surname.text,
            !cSurname.isEmpty else {
                missingFieldsAlert()
                return
        }
        
        newContact.name = cName
        newContact.surname = cSurname
        //newContact.imagePath =
        
        try? manager.writeDataToPlist(newContact: newContact)
    }
    
    private func missingFieldsAlert() {
        let alertController = UIAlertController(title: "Error", message:
            "Please enter name and surname", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
