//
//  GetDeviceReqResponse.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class GetDeviceReqResponse: BaseResponse {

    var list = [HelpListing]()
    
    init(response:NSDictionary) {
        let reqs = response["requests"] as! NSArray
//        var i = 0
        for item in reqs{
            let helpItem = HelpListing(data: item as! NSDictionary)
//            i += 1
//            if i == 2{
//                helpItem.subject = "Need food and water"
//                helpItem.description = "Have no water or food supply for my kids. We are standard in the apartment with no electricity. Need Help"
//                helpItem.loc = "12075-12795, County Rd O, Claremont, Ripley Township, Dodge County, MN, US, 55924, 4648"
//                helpItem.resource = ResourceType.Food
//            }
            list.append(helpItem)
        }
    }
}
