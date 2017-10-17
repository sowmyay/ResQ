//
//  BaseHandler.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class BaseHandler: NSObject {

    var dictionary = [String:AnyObject]()
    
    required override init() {
        super.init()
        
        print("\(self) - Handler Initialised")
    }
    
    func getHTTPMethod(_ request:BaseRequest) -> String {
        return "GET"
    }
    
    func getURL(_ request:BaseRequest) -> String {
        return  C.URL.testPath
        
    }
    
    @discardableResult
    func constructDictionary(_ request:BaseRequest) -> [String:AnyObject] {
        dictionary["device_id"] = request.deviceId as AnyObject?
        dictionary["platform"] = request.platform as AnyObject?
        dictionary["osVersion"] = request.osVersion as AnyObject?
        
        return dictionary
    }
    
    func parser(_ response: AnyObject) -> BaseResponse? {
        return nil
    }
    
    deinit {
        print("\(self) - Handler Released")
    }
}
