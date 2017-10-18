//
//  GetDetailsResponse.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class GetDetailsResponse: BaseResponse {

    var comments = [Comment]()
    let count:Int?
    let views:Int?
    init(response:NSDictionary){
        if let commentsList = response["comments"] as? NSArray{
            for item in commentsList{
                let c = Comment(data: item as! NSDictionary)
                comments.append(c)
            }
        }
        count = response["count"] as? Int
        views = response["views"] as? Int
    }
}

class Comment{
    let id:Int?
    let desc:String?
    let createdAt:String?
    let updatedAt:String?
    
    init(data:NSDictionary){
        self.id = data["id"] as? Int
        self.desc = data["description"] as? String
        self.createdAt = data["created_at"] as? String
        self.updatedAt = data["updated_at"] as? String
        
    }
    
}
