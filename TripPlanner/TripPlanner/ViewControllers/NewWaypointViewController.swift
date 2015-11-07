//
//  NewWaypointViewController.swift
//  TripPlanner
//
//  Created by Tyler Hoffman on 2015/10/26.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps

class NewWaypointViewController: UIViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var currTrip: Trip?
    var placesClient: GMSPlacesClient?
    var autoComp: [GMSAutocompletePrediction] = []
    var selectedWaypoint: GMSAutocompletePrediction?
    var selectedPlace: GMSPlace?
    var placeID: String?
    let regionRadius: CLLocationDistance = 10000
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient()
        //placeAutocomplete("Sydne")
        searchTableView.reloadData()
        searchBar.delegate = self
        //mapView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeAutocomplete(searchString: String) {
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.City
        placesClient?.autocompleteQuery(searchString, bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
            }
            self.autoComp = []
            for result in results! {
                if let result = result as? GMSAutocompletePrediction {
                    //print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                    self.autoComp.append(result)
                }
            }
            self.searchTableView.reloadData()
        })
    }

}

extension NewWaypointViewController{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComp.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WayCell")!
        cell.textLabel?.text = autoComp[indexPath.row].attributedFullText.string
        
        return cell
    }
    
    ///http://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial
    func centerMapOnLocation(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWaypoint = autoComp[indexPath.row]
        placeID = selectedWaypoint?.placeID
        placesClient!.lookUpPlaceID(placeID!, callback: { (place: GMSPlace?, error: NSError?) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(place.formattedAddress)")
                print("Place placeID \(place.placeID)")
                print("Place attributions \(place.attributions)")
                print("lat \(place.coordinate.latitude)")
                
                self.selectedPlace = place
                
                self.mapView.setCenterCoordinate(place.coordinate, animated: true)
                self.centerMapOnLocation(place.coordinate)
                
                let annotationsToRemove = self.mapView.annotations.filter { $0 !== self.mapView.userLocation }
                self.mapView.removeAnnotations( annotationsToRemove )
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = place.coordinate
                self.mapView.addAnnotation(annotation)
            } else {
                print("No place details for \(self.placeID)")
            }
            
        })
        //self.performSegueWithIdentifier("ShowTrip", sender: self)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.characters.count > 0){
            placeAutocomplete(searchText)
        } else {
            self.autoComp = []
            self.searchTableView.reloadData()
        }
    }
    
}





