//
//  ReqListHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqListHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/requests.json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let listReq = request as! ReqListRequest
        dictionary["lat"] = listReq.latitude as AnyObject
        dictionary["lon"] = listReq.longitude as AnyObject
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        
        let data = response as! NSDictionary
        return ReqListResponse(response: data)
    }
}
