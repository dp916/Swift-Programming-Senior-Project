//
//  PopUpController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit

class PopUpController: UIViewController
{

    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        answerLabel.text = qAnswer[myIndex]
    }
    
    //makes the popup go away and back to prevous view.

    
    @IBAction func back(_ sender: Any)
    {
        dismiss(animated: true)
    }
    
}
