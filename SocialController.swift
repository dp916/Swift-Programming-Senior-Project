//
//  UITableViewController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import StoreKit


class SocialController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func facebook(_ sender: Any)
    {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/thinkinsidethebun/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func instagram(_ sender: Any)
    {
        UIApplication.shared.open(URL(string: "https://www.instagram.com/thinkinsidethebun/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func twitter(_ sender: Any)
    {
        UIApplication.shared.open(URL(string: "https://twitter.com/bun_family")! as URL, options: [:], completionHandler: nil)
    }

    
    @IBAction func star(_ sender: Any)
    {
        SKStoreReviewController.requestReview()
    }
    
}


