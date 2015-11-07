//
//  TripViewController.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/26.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit


class TripViewController: UIViewController {
    
    var currTrip: Trip?
    var waypoints: [Waypoint] = []
    var selectedWaypoint: Waypoint?
    var coreDataStack: CoreDataStack?
    
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var waypointTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currTrip = currTrip {
            tripNameLabel.text = currTrip.locationDescription
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
//        if let currTrip = currTrip {
//            tripNameLabel.text = currTrip.locationDescription
//        }
        
        waypoints = CoreDataHelper(coreDataStack: coreDataStack!).returnWaypoints(currTrip!)
        waypointTableView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSegue2(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier{
            switch identifier {
            case "Save":
                print("ADDWaypoint")
                let source = segue.sourceViewController as! NewWaypointViewController
                CoreDataHelper(coreDataStack: coreDataStack!).addWaypoint(source.currTrip!, waypoint: source.selectedPlace!)
                waypoints = CoreDataHelper(coreDataStack: coreDataStack!).returnWaypoints(currTrip!)
                waypointTableView.reloadData()
            case "Cancel":
                print("No Waypoint")
            default:
                print("No Trip")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "AddMore") {
            let waypointViewController = segue.destinationViewController as! NewWaypointViewController
            waypointViewController.currTrip = currTrip
        }
        if (segue.identifier == "ShowWaypoint"){
            let viewWaypointViewController = segue.destinationViewController as! ViewWaypointViewController
            viewWaypointViewController.waypoint = selectedWaypoint
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TripViewController{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waypoints.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WaypointCell")!
        cell.textLabel?.text = waypoints[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWaypoint = waypoints[indexPath.row]
        
        self.performSegueWithIdentifier("ShowWaypoint", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            //let waypointToDelete = waypoints[indexPath.row]
            
            //CoreDataHelper(coreDataStack: coreDataStack).deleteTrip(tripToDelete)
            
            //trips = CoreDataHelper(coreDataStack: coreDataStack).returnAllTrips()
            //plannedTripsTableView.reloadData()
        }
    }
}
