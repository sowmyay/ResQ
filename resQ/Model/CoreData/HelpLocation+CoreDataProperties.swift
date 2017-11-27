//
//  HelpLocation+CoreDataProperties.swift
//  
//
//  Created by sowmya yellapragada on 11/11/17.
//
//

import Foundation
import CoreData


extension HelpLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HelpLocation> {
        return NSFetchRequest<HelpLocation>(entityName: "HelpLocation")
    }

    @NSManaged public var address: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var phone: String?
    @NSManaged public var title: String?
    @NSManaged public var discipline: String?
    @NSManaged public var locationName: String?

}
