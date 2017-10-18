//
//  CreateRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class CreateRequest: BaseRequest {
    let lat:Double
    let lng:Double
    let type:Bool
    let name:String
    let subject:String
    let desc:String
    
    init(lat:Double, lng:Double, reqType:Bool, name:String, subject:String, desc:String){
        self.lat = lat
        self.lng = lng
        self.type = reqType
        self.name = name
        self.subject = subject
        self.desc = desc
    }

}
