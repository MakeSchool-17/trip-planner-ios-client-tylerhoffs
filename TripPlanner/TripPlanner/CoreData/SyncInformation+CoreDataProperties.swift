//
//  SyncInformation+CoreDataProperties.swift
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

extension SyncInformation {

    @NSManaged var lastSyncTimestamp: NSNumber?
    @NSManaged var unsyncedDeletedTrips: String?

}
