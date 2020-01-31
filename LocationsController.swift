//
//  LocationsController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class LocationsController: UIViewController, CLLocationManagerDelegate
{
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var display: UILabel!
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var dataArray = [Double]()
    var power = [Int]()
    
    var x : Int = 0
    var y : Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ref = Database.database().reference()


        databaseHandle = ref?.child("Location/Latitude").observe(.value, with: { (snapshot) in
            let lati = snapshot.value as? Double
            if let la = lati
            {
            self.dataArray.append(la)
            //print(self.a)
            }
        })
        
        databaseHandle = ref?.child("Location/Power").observe(.value, with: { (snapshot) in
            let pow = snapshot.value as? Int
            if let po = pow
            {
                self.power.append(po)
                self.y = self.power.last!
            }
            
        })
        
        databaseHandle = ref?.child("Location/Longitude").observe(.value, with: { (snapshot) in
            let long = snapshot.value as? Double
            if let lo = long
            {
            self.dataArray.append(lo)
            //print(self.a)
                
            if self.y == 1
            {
                let lat = self.dataArray.removeFirst()
                let lon = self.dataArray.removeLast()
                
                //print(let,lon)
                
                self.display.text = "Food Truck: Open"
                self.getCurrent()
                self.home(xLatitude: lat, yLatitude: lon)
                
            }
            else
            {
                self.dataArray.removeAll()
                self.display.text = "Food Truck: Closed"
                self.getDefault()
                self.home()
            }
                
            }
        })
        
        

    }
    
    func getCurrent()
    {
        ref = Database.database().reference()
        databaseHandle = ref?.child("Address/Current").observe(.value, with: { (snapshot) in
            let add = snapshot.value as? String
            if let ad = add
            {
                self.address.text = ad
            }
        })
    }

    func getDefault()
    {
        self.address.text = "Location Not Available \nCheck Again Tomorrow"
    }
    
    
    
    func home(xLatitude: Double, yLatitude: Double)
    {
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(xLatitude, yLatitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Think Inside The Bun"
        annotation.subtitle = "Catering & Food Truck"
        map.addAnnotation(annotation)
        
    }
    func home()
    {
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.956552, -121.295131)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Think Inside The Bun"
        annotation.subtitle = "Catering & Food Truck"
        map.addAnnotation(annotation)
        
    }
    
    
    @IBAction func website(_ sender: Any)
    {
        UIApplication.shared.open(URL(string: "https://www.thinkinsidethebun.com")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func directions(_ sender: Any)
    {
        ref = Database.database().reference()
        
        
        databaseHandle = ref?.child("Location/Latitude").observe(.value, with: { (snapshot) in
            let lati = snapshot.value as? Double
            if let la = lati
            {
                self.dataArray.append(la)
                //print(self.a)
            }
        })
        
        databaseHandle = ref?.child("Location/Longitude").observe(.value, with: { (snapshot) in
            let long = snapshot.value as? Double
            if let lo = long
            {
                self.dataArray.append(lo)
                //print(self.a)
                let q = self.dataArray.removeFirst()
                let w = self.dataArray.removeLast()
                let coordinate = CLLocationCoordinate2DMake(q,w)
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                mapItem.name = "Food Truck Location"
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            }
        })
    
    }

}
