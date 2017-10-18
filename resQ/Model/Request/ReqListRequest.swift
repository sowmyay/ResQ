//
//  ReqListRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqListRequest: BaseRequest {
    var latitude: Double?
    var longitude: Double?
    
    init(lat:Double?, lon:Double?){
        self.latitude = lat
        self.longitude = lon
    }
}
