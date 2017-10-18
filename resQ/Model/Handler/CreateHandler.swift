//
//  CreateHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class CreateHandler: BaseHandler {
    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "POST"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/requests.json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let create = request as! CreateRequest
        dictionary["device_id"] = create.deviceId as AnyObject
        dictionary["lat"] = create.lat as AnyObject
        dictionary["lon"] = create.lng as AnyObject
        dictionary["help_type"] = create.type as AnyObject
        dictionary["name"] = create.name as AnyObject
        dictionary["subject"] = create.subject as AnyObject
        dictionary["description"] = create.desc as AnyObject
        
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        let data = response as! NSDictionary
        return CreateResponse(response: data)
    }
}
