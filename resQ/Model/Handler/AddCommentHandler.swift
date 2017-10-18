//
//  AddCommentHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class AddCommentHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "POST"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/requests.json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let add = request as! AddCommentRequest
        dictionary["device_id"] = add.deviceId as AnyObject
        dictionary["request_id"] = add.requestId as AnyObject
        dictionary["description"] = add.desc as AnyObject
        
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        let data = response as! NSDictionary
        return AddCommentResponse(response: data)
    }
}
