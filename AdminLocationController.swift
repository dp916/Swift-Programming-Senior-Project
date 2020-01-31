//
//  AdminLocationController.swift
//  ThinkInsideTheBun
//
//  Created by Danny Pham 
//  Copyright © 2019 Danny Pham. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class AdminLocationController: UIViewController, CLLocationManagerDelegate
{
    @IBOutlet weak var update: MKMapView!
    
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var power: UISwitch!
    
    
    var locationManager = CLLocationManager()
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    var data = [Double]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.update.showsUserLocation = true
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("Current Location = \(locValue.latitude) \(locValue.longitude)")
        
        
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        update.setRegion(viewRegion, animated: true)
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation!) { (placemark, error) in
            if error != nil
            {
                print("Reload")
                
            }
            else
            {
                if let place = placemark?[0]
                {
                    if let checker = place.subThoroughfare
                    {
                        print(checker)
                        self.label.text = "\(place.subThoroughfare!) \(place.thoroughfare!) \n \(place.locality!) \(place.administrativeArea!) \(place.postalCode!)"
                        
                        let s = self.label.text
                        
                        self.ref = Database.database().reference()
                        
                        self.ref?.child("Address/Current").setValue(s)
                    }
                }
            }
        }
        
    }
    
    func save()
    {
        ref = Database.database().reference()
        
        let val: CLLocationCoordinate2D = locationManager.location!.coordinate
        let x1 = val.latitude
        let y1 = val.longitude
        
        self.ref?.child("Location/Latitude").setValue(x1)
        self.ref?.child("Location/Longitude").setValue(y1)

        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(x1, y1)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
       update.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Think Inside The Bun"
        annotation.subtitle = "Catering & Food Truck"
      update.addAnnotation(annotation)
        locationSaved()
        
        
        
    }
    

    @IBAction func u(_ sender: Any)
    {
        save()
    }
    
    @IBAction func share(_ sender: Any)
    {
        ref = Database.database().reference()
        databaseHandle = ref?.child("Address/Current").observe(.value, with: { (snapshot) in
            let street = snapshot.value as? String
            if let str = street
            {
                let activityViewController = UIActivityViewController(activityItems: ["My Food Truck is located: " + str], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
        })
        
    }
    
    
    func arena()
    {
        ref = Database.database().reference()

        self.ref?.child("Location/Latitude").setValue(37.956552)
        self.ref?.child("Location/Longitude").setValue(-121.295131)
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.956552, -121.295131)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        update.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Think Inside The Bun"
        annotation.subtitle = "Catering & Food Truck"
        update.addAnnotation(annotation)
        
    }
    
    
    func locationSaved()
    {
        let alert = UIAlertController(title: "Current Location Saved", message: "Your food truck location is saved", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func open()
    {
        let alert = UIAlertController(title: "Food Truck is now Open", message: "You have shared your saved location", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func close()
    {
        let alert = UIAlertController(title: "Food Truck is now Closed", message: "Your food truck hours are listed", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func on(_ sender: Any)
    {
        ref = Database.database().reference()
        self.ref?.child("Location/Power").setValue(1)
        open()
    }
    
    
    @IBAction func off(_ sender: Any)
    {
        ref = Database.database().reference()
        self.ref?.child("Location/Power").setValue(0)
        close()
    }
    
    
}
