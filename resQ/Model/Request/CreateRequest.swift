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
    let type:Int
    let name:String
    let subject:String
    let desc:String
    let id: Int
    let createdAt:String
    let updatedAt:String
    let userId:Int
    
    init(lat:Double, lng:Double, reqType:Int, name:String, subject:String, desc:String){
        self.lat = lat
        self.lng = lng
        self.type = reqType
        self.name = name
        self.subject = subject
        self.desc = desc
        self.id = 11
        self.createdAt = "Less than a minute ago"
        self.updatedAt = "Less than a minute ago"
        self.userId = 1
    }

}
