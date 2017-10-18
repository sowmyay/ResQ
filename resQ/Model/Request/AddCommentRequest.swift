//
//  AddCommentRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class AddCommentRequest: BaseRequest {

    let requestId:Int
    let desc:String
    
    init(id: Int, desc:String){
        self.requestId = id
        self.desc = desc
    }
    
}
