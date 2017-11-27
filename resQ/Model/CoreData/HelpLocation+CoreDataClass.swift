//
//  HelpLocation+CoreDataClass.swift
//  
//
//  Created by sowmya yellapragada on 11/11/17.
//
//

import Foundation
import CoreData


public class HelpLocation: NSManagedObject {

    convenience init(loc: Location, context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "HelpLocation", in: context) {
            self.init(entity: ent, insertInto: context)
            self.title = loc.title
            self.locationName = loc.locationName
            self.discipline = loc.discipline
            self.lat = loc.coordinate.latitude
            self.lng = loc.coordinate.longitude
            self.phone = loc.phone
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
