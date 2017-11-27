//
//  LocationsRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/23/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class LocationsRequest: BaseRequest {
    let id:Int
    var lat: Double?
    var lng: Double?
    
    init(id:Int,lat:Double, lng:Double){
        self.id = id
        self.lat = lat
        self.lng = lng
    }
}
