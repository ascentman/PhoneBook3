//
//  ViewController.swift
//  PhoneBook3
//
//  Created by Vova on 8/28/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

//let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//let settingsURL = URL(fileURLWithPath: documentDirectory.appending("Contact.plist"))

class TableViewController: UITableViewController {
    
    private var contacts : [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        try? fileObject.readDataFromPlist()
        self.applyAppearence()
    
        //read

    }
    
    @IBAction func unwindToTableViewController(segue: UIStoryboardSegue) {
        if let vc = segue.source as? ContactViewController {
            contacts.append(vc.newContact)
        }
        tableView.reloadData()
    }
}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier(), for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.updateName(contact.name)
        cell.updateSurname(contact.surname)
        //cell.updateImageView(UIImage(contentsOfFile: contact.imagePath!))
        cell.applyAppearence()
        return cell
    }
    
}
