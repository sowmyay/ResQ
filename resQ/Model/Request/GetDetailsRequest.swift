//
//  GetDetailsRequest.swift
//  resQ
//
//  Created by sowmya yellapragada on 10/17/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit

class GetDetailsRequest: BaseRequest {

    let id:Int
    init(requestID:Int){
        self.id = requestID
    }
}
