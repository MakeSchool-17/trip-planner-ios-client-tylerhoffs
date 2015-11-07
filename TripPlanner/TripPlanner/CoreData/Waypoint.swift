//
//  Waypoint.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/27.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import CoreData

final class Waypoint: NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName("Waypoint", inManagedObjectContext:
            context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }

}
