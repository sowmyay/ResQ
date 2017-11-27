//
//  Singleton.swift
//  resQ
//
//  Created by sowmya yellapragada on 11/15/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import Foundation


class Singleton: NSObject {
    static let instance = Singleton()
    
    ///This makes sure that we can't get an instance variable of Singlton.
    private override init() {
        super.init()
    }
    
    var name:String = "Sowmya"
    var phone:String = "2019144682"
}
