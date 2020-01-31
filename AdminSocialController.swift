//
//  AdminSocialController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import Social
import AVFoundation


class AdminSocialController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var library: UIBarButtonItem!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var picture: UIImageView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }

    
    @IBAction func screenshot(_ sender: Any)
    {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        var imagesToShare = [AnyObject]()
        imagesToShare.append(image!)
        
        
        
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func libraryAction(_ sender: Any)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cameraAction(_ sender: Any)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func text(_ sender: Any)
    {
        let activityViewController = UIActivityViewController(activityItems: ["via Think Inside The Bun App"], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
}
