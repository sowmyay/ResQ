//
//  RespondHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class RespondHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "POST"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/requests/respond.json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let respond = request as! RespondRequest
        dictionary["device_id"] = respond.deviceId as AnyObject
        dictionary["request_id"] = respond.reqId as AnyObject
        
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        let data = response as! NSDictionary
        return RespondResponse(response: data)
    }
}
