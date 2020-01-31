//
//  FormController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import MessageUI

class FormController: UIViewController, MFMailComposeViewControllerDelegate
{
    
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var date: UITextField!
    @IBOutlet var time: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var total: UITextField!
    @IBOutlet var meat: UITextField!
    @IBOutlet weak var side: UITextField!
    @IBOutlet weak var salad: UITextField!

    
    @IBOutlet var note: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
    }
    
    @IBAction func Submit(_ sender: UIButton)
    {
        if name.text == ""
        {
            nameAlert()
        }
        
        if email.text == ""
        {
            emailAlert()
        }
        
        let e = isValidEmail(testStr: email.text!)
        
        if e != true
        {
            emailAlert()
        }
        
        let p = validatePhone(value: phone.text!)
        
        if p != true
        {
            phoneAlert()
        }
        
        if date.text == ""
        {
            dateAlert()
        }
        
        let d = isValidDate(dateString: date.text!)
        if d != true
        {
            dateAlert()
        }
        
        if time.text == ""
        {
            timeAlert()
        }
        
        
        if address.text == ""
        {
            addressAlert()
        }
        
        
        if total.text == ""
        {
            attendeeAlert()
        }
        
        let q:Int? = Int(total.text!)
        if total.text?.count != 0 && q! < 5
        {
            attendeeAlert()
        }
   
        
        
        let toRecipients = ["andre@thinkinsidethebun.com"]
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        mc.setToRecipients(toRecipients)
        mc.setSubject("Think Inside The Bun - Catering Request Form")
        
        mc.setMessageBody("Catering Request Form\n\nName:      \(name.text!) \n\nEmail:       \(email.text!) \n\nPhone:      \(phone.text!) \n\nDate:        \(date.text!) \n\nTime:        \(time.text!) \n\nAddress:   \(address.text!) \n\nTotal:         \(total.text!)  \n\nMeats:      \(meat.text!) \n\nSalads:      \(salad.text!) \n\nSides:        \(side.text!) \n\nNotes:      \(note.text!)\n\n\n*** Your request will be processed and we will contact you to confirm the order.***\nThank You.\n- Think Inside The Bun", isHTML: false)
        
        self.present(mc, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func isValidDate(dateString: String) -> Bool
    {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if let _ = dateFormatterGet.date(from: dateString)
        {
            //date parsing succeeded, if you need to do additional logic, replace _ with some variable name i.e date
            return true
        }
        else
        {
            // Invalid date
            return false
        }
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func validatePhone(value: String) -> Bool
    {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
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
    
    func phoneAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your phone number \n123-456-7890", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func dateAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your date \nYYYY-MM-DD", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func timeAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your time \nHH:MM AM/PM", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func addressAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your event address", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func attendeeAlert()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your attendee amount \nMinimum: 5", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any)
    {
        self.resignFirstResponder()
    }
    
}
