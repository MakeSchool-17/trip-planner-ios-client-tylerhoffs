//
//  Trip+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/27.
//  Copyright © 2015 Make School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trip {

    @NSManaged var lastUpdate: NSNumber?
    @NSManaged var location: NSObject?
    @NSManaged var locationDescription: String?
    @NSManaged var parsing: NSNumber?
    @NSManaged var serverID: String?
    @NSManaged var waypoints: NSSet?

}
