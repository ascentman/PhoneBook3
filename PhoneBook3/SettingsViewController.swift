//
//  SettingsViewController.swift
//  PhoneBook3
//
//  Created by Vova on 8/29/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var darkThemeSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let theme = UserDefaults.standard.value(forKey: "Selected theme") as? Bool {
            darkThemeSwitch.isOn = theme
        }
    }
    
    @IBAction func darkThemeChanged(_ sender: UISwitch) {
        
        if darkThemeSwitch.isOn {
            Theme.dark.apply()
        }
        else {
            Theme.light.apply()
        }
        self.applyAppearence()
        UserDefaults.standard.set(sender.isOn, forKey: "Selected theme")
    }
}

extension UIViewController {
    
    func applyAppearence() {
        UIView.animate(withDuration: 0.6) {
            self.navigationController?.navigationBar.barTintColor = Theme.current.backgroundColor
            self.navigationController?.navigationBar.tintColor = Theme.current.textColor
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.current.textColor]
            self.navigationController?.navigationBar.layoutIfNeeded()
        }
    }
}
