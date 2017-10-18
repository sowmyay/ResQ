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
        let reqs = response["list"] as! NSArray
        for item in reqs{
            let helpItem = HelpListing(data: item as! NSDictionary)
            list.append(helpItem)
        }
    }
}

class HelpListing{
    let id:Int?
    let subject:String?
    let description:String?
    let views:Int?
    let lat:Double?
    let lon:Double?
    let loc:String?
    let resource:ResourceType?
    let status:Int?
    let createdAt:String?
    let updatedAt:String?
    
    init(data:NSDictionary){
        id = data["id"] as? Int
        subject = data["subject"] as? String
        description = data["description"] as? String
        views = data["views"] as? Int
        lat = data["lat"] as? Double
        lon = data["lon"] as? Double
        loc = data["location"] as? String
        status = data["status"] as? Int
        createdAt = data["create_at"] as? String
        updatedAt = data["updated_at"] as? String
        
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
