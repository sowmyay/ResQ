//
//  BaseRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class BaseRequest: NSObject {

    var deviceId:String     = (UIDevice.current.identifierForVendor?.uuidString)!
    var version:String      = "1.0"
    var platform:String     = "ios"
    var osVersion:String    = UIDevice.current.systemVersion
    var httpMethod:String?  = nil
    var requestType:String? = nil
    var apiName:String?     = ""
    
    override init() {
        super.init()
    }
}
