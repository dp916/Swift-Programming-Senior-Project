//
//  AdminHomeController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import Firebase

class AdminHomeController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(AdminHomeController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem)
    {
        // Perform your custom actions
        // ...
        try! Auth.auth().signOut()
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: false)
    }

}
