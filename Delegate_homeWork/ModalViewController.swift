//
//  ViewController.swift
//  Delegate_homeWork
//
//  Created by Bekzat on 15/12/24.
//

import UIKit

protocol AddContactDelegate {
    func addContact(_ contact: String)
}

class ModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var delegate: AddContactDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        tap.delegate = self //delegate UIGestureRecognizer
        view.addGestureRecognizer(tap)
        
        myView.layer.cornerRadius = 20
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: myView))! {
            return false
        } else {
            return true
        }
    }
    
    
    @IBAction func addContactButton(_ sender: Any) {
        guard let contact = textField.text, !contact.isEmpty else {
            showErrorAlert()
            return
        }
        
        delegate?.addContact(contact)
        
        dismiss(animated: true)
        
        
    }
    
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Name can't be empty. Please enter the name", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.textField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
