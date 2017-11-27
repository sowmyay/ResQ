//
//  LocationsResponse.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/23/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import MapKit

class LocationsResponse: BaseResponse {

    var locations = [Location]()
    
    init(response:NSDictionary) {
        if let locs = response["hospitals"] as? NSArray{
            for item in locs{
                let loc = Location(data: item as! NSDictionary, type: "hospitals")
                locations.append(loc)
            }
            
//            let tempLocs = [["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.785113",
//                             "lon" : "-84.411807",
//                             "name" : "Esc. Rafael Martinez Nadal"],
//                            ["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.773092",
//                             "lon" : "-84.413459",
//                             "name" : "Esc. Rafael Martinez Nadal"],
//                            ["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.781564",
//                             "lon" : "-84.401937",
//                             "name" : "Esc. Rafael Martinez Nadal"]]
//
//            for item in tempLocs{
//                let loc = Location(data: item as NSDictionary, type: "hospitals")
//                locations.append(loc)
//            }
        }else if let locs = response["shelters"] as? NSArray{
            for item in locs{
                let loc = Location(data: item as! NSDictionary, type: "shelters")
                locations.append(loc)
            }
//            let tempLocs = [["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.785505",
//                             "lon" : "-84.399834",
//                             "name" : "Esc. Rafael Martinez Nadal"],
//                            ["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.770095",
//                             "lon" : "-84.408610",
//                             "name" : "Esc. Rafael Martinez Nadal"],
//                            ["address" : "12 Calle Carrion Maduro,Yauco,PR,00698",
//                             "lat" : "33.770131",
//                             "lon" : "-84.414704",
//                             "name" : "Esc. Rafael Martinez Nadal"]]
//
//            for item in tempLocs{
//                let loc = Location(data: item as NSDictionary, type: "shelters")
//                locations.append(loc)
//            }
        }
        
    }
}

class Location: NSObject, MKAnnotation{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    let phone:String?
    
    init(data:NSDictionary, type:String) {
        self.title = data["name"] as? String
        self.locationName = data["address"] as! String
        self.discipline = type
        let lat = Double(data["lat"] as! String)
        let lng = Double(data["lon"] as! String)
        self.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        self.phone = data["phone"] as? String
    }
    init(title:String, locName:String, dis:String, lat:Double, lng:Double, phone:String?){
        self.title = title
        self.locationName = locName
        self.discipline = dis
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.phone = phone
    }
    init(loc:HelpLocation){
        self.title = loc.title
        self.locationName = loc.locationName!
        self.discipline = loc.discipline!
        self.coordinate = CLLocationCoordinate2D(latitude: loc.lat, longitude: loc.lng)
        self.phone = loc.phone
    }
    var subtitle: String? {
        return locationName
    }
}

