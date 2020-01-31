//
//  ContactController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import MessageUI

class ContactController: UIViewController, MFMailComposeViewControllerDelegate
{
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var messageField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
 
    }
    
    
    @IBAction func Send(_ sender: Any)
    {
        if nameField.text == ""
        {
            nameAlert()
        }
        
        if emailField.text == ""
        {
            emailAlert()
        }
        
        let e = isValidEmail(testStr: emailField.text!)
        
        if e != true
        {
            emailAlert()
        }
        
        
        if messageField.text == ""
        {
            messageAlert()
        }
        
        
        
        let toRecipients = ["andre@thinkinsidethebun.com"]
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipients)
        mc.setSubject("Think Inside The Bun - Contact Form")
        
        mc.setMessageBody("Contact Form\n \nName:     \(nameField.text!) \n\nEmail:      \(emailField.text!) \n\nPhone:    \(phoneField.text!) \n\nMessage:\n\n \(messageField.text!)", isHTML: false)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func nameAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your name", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
    
    func emailAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your email \naddress@email.com", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func messageAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your message", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyBoard(_ sender: Any)
    {
        self.resignFirstResponder()
    }

    
}
