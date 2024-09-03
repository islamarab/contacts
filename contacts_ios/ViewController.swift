//
//  ViewController.swift
//  contacts_ios
//
//  Created by iskapc on 03.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addContact(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let contactName = nameTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        
        let newContact = Contact(name: contactName, phoneNumber: phoneNumber)
        
        do {
            if let data = defaults.data(forKey: "contacts") {
                var contacts = try JSONDecoder().decode([Contact].self, from: data)
                contacts.append(newContact)
                let encodedData = try JSONEncoder().encode(contacts)
                defaults.set(encodedData, forKey: "contacts")
            } else {
                let encodedData = try JSONEncoder().encode([newContact])
                defaults.set(encodedData, forKey: "contacts")
            }
        } catch {
            print("unable to encode \(error)")
        }
        
        nameTextField.text = ""
        phoneNumberTextField.text = ""
    }
    
}

