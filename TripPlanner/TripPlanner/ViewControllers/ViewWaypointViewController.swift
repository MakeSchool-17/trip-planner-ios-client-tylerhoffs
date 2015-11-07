//
//  ViewWaypointViewController.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/26.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit
import MapKit

class ViewWaypointViewController: UIViewController {
    var waypoint: Waypoint?
    let regionRadius: CLLocationDistance = 10000
    
    @IBOutlet weak var waypointLabel: UILabel!
    @IBOutlet weak var waypointImage: UIImageView!
    @IBOutlet weak var waypointMap: MKMapView!
    
    ///http://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
    func centerMapOnLocation(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.waypointMap.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waypointLabel.text = waypoint?.name
        let lat = Double((waypoint?.latitude)!)
        let lon = Double((waypoint?.longitude)!)
        let coords = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        
        self.waypointMap.setCenterCoordinate(coords, animated: true)
        self.centerMapOnLocation(coords)
        
        let annotationsToRemove = self.waypointMap.annotations.filter { $0 !== self.waypointMap.userLocation }
        self.waypointMap.removeAnnotations( annotationsToRemove )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        self.waypointMap.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
