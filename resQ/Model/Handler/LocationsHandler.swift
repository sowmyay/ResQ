//
//  LocationsHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/23/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit


class LocationsHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        var urlStr = super.getURL(request)
        let loc = request as! LocationsRequest
        switch loc.id {
        case 0:
            urlStr += "/hospitals.json"
        default:
            urlStr += "/shelters.json"
        }
        return urlStr
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let loc = request as! LocationsRequest
        dictionary["lat"] = loc.lat as AnyObject
        dictionary["lon"] = loc.lng as AnyObject
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        
        let data = response as! NSDictionary
        return LocationsResponse(response: data)
    }
    
}


