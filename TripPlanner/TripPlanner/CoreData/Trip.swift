//
//  Trip.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/27.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import CoreData

final class Trip: NSManagedObject, TripPlannerManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init(context: NSManagedObjectContext){
        let entityDescription = NSEntityDescription.entityForName("Trip", inManagedObjectContext: context)!
        self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    }

}
