//
//  loginViewController.swift
//  ThinkInsideTheBun
//
//  Created by Alek Miller 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import Firebase

class loginViewController: UIViewController
{

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let u = user
            {
                // User is signed in.
                self.performSegue(withIdentifier: "goToSettings", sender: self)
            }

        }
 */
    }
    
    
    @IBAction func LoginButtonClicked(_ sender: UIButton)
    {
        if emailTextField.text == ""
        {
            emailEmpty()
        }
        
        let e = isValidEmail(testStr: emailTextField.text!)
        
        if e != true
        {
            emailEmpty()
        }
        
        if passwordTextField.text == ""
        {
            passwordEmpty()
        }
        
        //TODO: some Validation on email and password.
        
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
    
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                //print("\n\n*********** \(email) *************\n\n")
                //print("\n\n*********** \(pass) *************\n\n")
                
                
                //Check that user isnt nil
                if let u = user {
                
                    //user found, go to setting page.
                    self.performSegue(withIdentifier: "goToSettings", sender: self)
                    print(u)
                }
                else
                {
                    //get Error.
                    self.failedLogin()
                }
            }
        
        
        }
    }
    
    
    
    
    func emailEmpty()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your email \naddress@email.com", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func passwordEmpty()
    {
        let alert = UIAlertController(title: "Error: Required Field Format", message: "Please enter your password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func failedLogin()
    {
        let alert = UIAlertController(title: "Error: Incorrect Credentials", message: "Please enter your email and password", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    @IBAction func dismiss(_ sender: Any)
    {
        self.resignFirstResponder()
    }
    
    
}
