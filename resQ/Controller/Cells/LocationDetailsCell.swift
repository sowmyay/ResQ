//
//  LocationDetailsCell.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/23/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var lat:Double = 0.0
    var lng:Double = 0.0
    
    @IBAction func callTouch(_ sender: Any) {
    }
    @IBAction func directionsTouch(_ sender: Any) {
        
        // if GoogleMap installed
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(Float(lat)),\(Float(lng))&directionsmode=driving")! as URL)
            
        } else {
            // if GoogleMap App is not installed
            UIApplication.shared.openURL(NSURL(string:
                "https://maps.google.com/?q=@\(Float(lat)),\(Float(lng))")! as URL)
        }
        
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//            UIApplication.shared.openURL(URL(string:
//                "comgooglemaps://?center=\(lat),\(lng)&zoom=14&views=traffic")!)
//        }
    }
    
    func config(loc:Location, initialLocation:CLLocation){
        titleLbl.text = loc.title
        locationLbl.text = loc.locationName
        lat = loc.coordinate.latitude
        lng = loc.coordinate.longitude
        let helpLoc = CLLocation(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
        
        distance.text = String(format:"%.2f", 0.0006 * helpLoc.distance(from: initialLocation)) + " miles"
    }
}
