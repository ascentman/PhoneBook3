//
//  ContactViewController.swift
//  PhoneBook3
//
//  Created by Vova on 8/29/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit


protocol SendContactDelagate {
    func userDidEnterData(contact: Contact)
}

enum ContactViewControllerStates {
    case add
    case show
}

final class ContactViewController: ImagePickerClass {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    var currentState : ContactViewControllerStates = .add
    var newContact = Contact()
    var delegate : SendContactDelagate?
    private let manager = FileManagerClass()
    private let pickImage = ImagePickerClass()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentState == .show {
            showContactDetails()
        }
        nameLabel.text = newContact.name
        surnameLabel.text = newContact.surname
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        alertOptions()
    }
    
    override func selectedImage(choosen: UIImage) {
        imageView.image = choosen
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        guard let name = name.text,
            !name.isEmpty,
            let surname = surname.text,
            !surname.isEmpty else {
                presentAlert(withTitle: "Error", message: "Please enter name and surname")
                return
        }
        newContact.name = name
        newContact.surname = surname
        newContact.imagePath = try? manager.saveImageWith(fileName: imageView.image ?? UIImage(named: "empty")!)
        
        try? manager.writeDataToPlist(newContact: newContact)
        delegate?.userDidEnterData(contact: newContact)
        navigationController?.popViewController(animated: true)
    }
    
    private func showContactDetails() {
        self.title = "Details"
        saveButton.isHidden = true
        name.isHidden = true
        surname.isHidden = true
        imageView.isUserInteractionEnabled = false
        if let imagePath = newContact.imagePath {
            imageView.image = UIImage(contentsOfFile: (imagePath.path))
        }
    }
}

// MARK: - Extensions

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


