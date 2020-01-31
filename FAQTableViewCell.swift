//
//  FAQTableViewCell.swift
//  ThinkInsideTheBun
//
//  Created by Alek Miller 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell
{
    @IBOutlet weak var questionLabel: UILabel!
    
    func setQuestiion(question: String)
    {
       questionLabel.text = question
    }
    
}
