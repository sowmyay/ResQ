//
//  GetDetailsHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class GetDetailsHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        let listReq = request as! GetDetailsRequest
        return super.getURL(request)+"/requests"+String(listReq.id)+".json"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        
        let data = response as! NSDictionary
        return GetDetailsResponse(response: data)
    }
}
