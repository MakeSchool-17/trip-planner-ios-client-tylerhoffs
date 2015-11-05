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

    @IBOutlet weak var tripNameLabel: UILabel!
    
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
                //let source = segue.sourceViewController as! NewWaypointViewController
                //CoreDataHelper(coreDataStack: coreDataStack).addTrip(source.tripName!)
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
