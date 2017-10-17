//
//  TestHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class TestHandler: BaseHandler {

    override func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    override func getURL(_ request:BaseRequest) -> String {
        
        return super.getURL(request)+"/pet/findByStatus"
    }
    
    override func constructDictionary(_ request:BaseRequest) -> [String : AnyObject] {
        super.constructDictionary(request)
        let testRequest = request as! TestRequest
        
        return dictionary
    }
    
    override func parser(_ response: AnyObject) -> BaseResponse? {
        
        for item in (response as! NSArray){
            let data = item as! NSDictionary
            print(data)
            return TestResponse(response: data)
        }
        return super.parser(response)
    }
}
