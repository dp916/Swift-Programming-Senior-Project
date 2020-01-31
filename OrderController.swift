//
//  OrderController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OrderController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var menu = [String]()
    
    var myIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        
         
         // Set the firebase reference
         ref = Database.database().reference()
         
         // Retrieve the posts and listen for changes
         databaseHandle = ref?.child("Menu").observe(.childAdded, with: { (snapshot) in
         
            // Code to execute when a child is added under "menu"
            // Take the value from the snapshot and added it to the array
            
         //Try to convert the value of the data to a string
         let post = snapshot.value as? String
         if let actualPost = post
         {
            //Append the data to our menu array
            self.menu.append(actualPost)
            
            //print(self.menu)
            
            //Reload the tableview
            self.tableView.reloadData()
         }

         
         })
 
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = menu[indexPath.row]
        return cell!
    }



}
