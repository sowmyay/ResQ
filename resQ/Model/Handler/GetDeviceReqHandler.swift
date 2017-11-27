//
//  GetDeviceReqHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class GetDeviceReqHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/requests.json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let req = request as! GetDeviceReqRequest
        dictionary["device_id"] = req.deviceId as AnyObject
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        
        let data = response as! NSDictionary
        return GetDeviceReqResponse(response: data)
    }
}
