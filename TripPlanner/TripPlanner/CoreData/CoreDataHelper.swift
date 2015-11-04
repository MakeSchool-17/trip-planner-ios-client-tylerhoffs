//
//  CoreDataHelper.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/29.
//  Copyright © 2015 Make School. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper{

//    var managedObjectContext: NSManagedObjectContext
//    var coreDataStack = CoreDataStack(stackType: .SQLite)
//    
//    init(managedObjectContext: NSManagedObjectContext) {
//        self.managedObjectContext = managedObjectContext
//    }
    
    var managedObjectContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.managedObjectContext
    }
    
    func addTrip(tripName: String){
        
        let trip = Trip(context: self.managedObjectContext)
        
        
        //trip.setPrimitiveValue(tripName, forKey: "location")
        trip.locationDescription = tripName
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print(error.localizedDescription)
        }
        
        coreDataStack.save()
        
    }
    
    func returnAllTrips() -> [Trip]{
        let fetchRequest = NSFetchRequest(entityName: "Trip")
        let trips = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [Trip]
        print(trips.count)
        return trips
        
    }
}