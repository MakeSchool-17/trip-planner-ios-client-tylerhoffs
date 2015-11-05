//
//  PlannedTripsTableViewController.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/26.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit
import CoreData

class PlannedTripsTableViewController: UITableViewController {
    
    var trips: [Trip] = []
    var coreDataStack = CoreDataStack(stackType: .SQLite)
    var selectedTrip: Trip?

    
    @IBOutlet var plannedTripsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        plannedTripsTableView.dataSource = self
        plannedTripsTableView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //trips = CoreDataHelper(managedObjectContext: coreDataStack.managedObjectContext).returnAllTrips()
        trips = CoreDataHelper(coreDataStack: coreDataStack).returnAllTrips()
        plannedTripsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier{
                switch identifier {
                case "Add":
                    print("ADD")
                    let source = segue.sourceViewController as! NewTripViewController
                    //CoreDataHelper(managedObjectContext: coreDataStack.managedObjectContext).addTrip(source.tripName!)
                    CoreDataHelper(coreDataStack: coreDataStack).addTrip(source.tripName!)
                case "Cancel":
                    print("No Trip")
                default:
                    print("No Trip")
                }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowTrip") {
            let tripViewController = segue.destinationViewController as! TripViewController
            tripViewController.currTrip = selectedTrip
        }
    }


}

extension PlannedTripsTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell")!
        cell.textLabel?.text = trips[indexPath.row].locationDescription
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedTrip = trips[indexPath.row]
        
        self.performSegueWithIdentifier("ShowTrip", sender: self)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            let tripToDelete = trips[indexPath.row]
            
            CoreDataHelper(coreDataStack: coreDataStack).deleteTrip(tripToDelete)
            
            trips = CoreDataHelper(coreDataStack: coreDataStack).returnAllTrips()
            plannedTripsTableView.reloadData()
        }
    }
}
