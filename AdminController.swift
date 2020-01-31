//
//  AdminController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AdminController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    

    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var menu = [String]()
    
    
    var keyArray:[String] = []
    
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
                //Reload the tableview
                self.tableView.reloadData()
            }
            
            
        })
        
        
    }
    
    
    @IBAction func addItem(_ sender: Any)
    {
        let alert = UIAlertController(title: "Enter content", message: "Insert item into menu", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "Your content here"
            
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let textField = alert.textFields?.first
            if textField?.text != "" {
            self.ref?.child("Menu").childByAutoId().setValue(textField?.text)
                
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Admin", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            getAllKeys()
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when, execute:
                {
                self.ref?.child("Menu").child(self.keyArray[indexPath.row]).removeValue()
                self.menu.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            })
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func getAllKeys()
    {
        ref?.child("Menu").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.keyArray.append(key)
            }
        })
    }
    

    
}


