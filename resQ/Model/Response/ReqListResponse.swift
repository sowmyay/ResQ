//
//  ReqListResponse.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/16/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class ReqListResponse: BaseResponse {
    var list = [HelpListing]()
    
    init(response:NSDictionary) {
        let reqs = response["requests"] as! NSArray
        var i = 0
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

class HelpListing{
    let id:Int?
    var subject:String?
    var description:String?
    let views:Int?
    let lat:Double?
    let lon:Double?
    var loc:String?
    var resource:ResourceType?
    var status:Int?
    let createdAt:String?
    let updatedAt:String?
    var images:NSArray?
    var author:String?
    
    init(data:NSDictionary){
        id = data["id"] as? Int
        subject = data["subject"] as? String
        description = data["description"] as? String
        views = data["views"] as? Int
        lat = data["lat"] as? Double
        lon = data["lon"] as? Double
        loc = data["location"] as? String
        status = data["status"] as? Int
        createdAt = data["created_at"] as? String
        updatedAt = data["updated_at"] as? String
        images = data["images"] as? NSArray
        author = data["user_name"] as? String
        
        if let helpType = data["help_type"] as? Int{
            switch helpType{
            case 0 :
                resource = ResourceType.Evacuation
            case 1 :
                resource = ResourceType.Food
            case 2 :
                resource = ResourceType.Water
            case 3 :
                resource = ResourceType.Shelter
            default:
                resource = ResourceType.Others
            }
        }else{
            resource = ResourceType.Others
        }
    }
}

enum ResourceType : String{
    case Evacuation = "Evacuation"
    case Food = "Food"
    case Water = "Water"
    case Shelter = "Shelter"
    case Others = "Others"
    
    static var count: Int { return ResourceType.Others.hashValue + 1}
    static let allValues = [Evacuation, Food, Water, Shelter, Others]
}
