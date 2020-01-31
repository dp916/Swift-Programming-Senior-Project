//
//  GalleryController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//
import UIKit

class GalleryController: UIViewController
{
    @IBOutlet var collectionView: UICollectionView!
    
    var imgData = [#imageLiteral(resourceName: "fried-chicken"), #imageLiteral(resourceName: "fruitcup2"), #imageLiteral(resourceName: "cook2"), #imageLiteral(resourceName: "friedchicken3"), #imageLiteral(resourceName: "macheese"), #imageLiteral(resourceName: "biscuits"), #imageLiteral(resourceName: "cook3"), #imageLiteral(resourceName: "friedchicken4"), #imageLiteral(resourceName: "tacos"), #imageLiteral(resourceName: "cook"), #imageLiteral(resourceName: "friedchicken2"), #imageLiteral(resourceName: "bentos"), #imageLiteral(resourceName: "whipcup2"), #imageLiteral(resourceName: "berries"), #imageLiteral(resourceName: "appetizers"), #imageLiteral(resourceName: "strawbread"), #imageLiteral(resourceName: "bluebread"), #imageLiteral(resourceName: "shrimp2"), #imageLiteral(resourceName: "shrimp"), #imageLiteral(resourceName: "snacks")]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
}


extension GalleryController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return imgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.img.layer.borderWidth = 1
        cell.img.layer.masksToBounds = false
        cell.img.layer.borderColor = UIColor.black.cgColor
        cell.img.layer.cornerRadius = cell.img.frame.height/2
        cell.img.clipsToBounds = true
        cell.img.image = imgData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let imageInfo = GSImageInfo(image: imgData[indexPath.row], imageMode: .aspectFit)
        let transitionInfo = GSTransitionInfo(fromView: collectionView)
        let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
        imageViewer.dismissCompletion = { print("Dismiss called") }
        present(imageViewer, animated: true)
    }
}
