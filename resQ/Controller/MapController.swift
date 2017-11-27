//
//  MapController.swift
//  ResQ
//
//  Created by sowmya yellapragada on 10/8/17.
//  Copyright © 2017 sowmya.yellapragada. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class MapController: BaseController, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, FilterDelegate{
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterScreen: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?{
        didSet{
            fetchedResultsController?.delegate = self
        }
    }
    
    // set initial location
    var initialLocation = CLLocation(latitude: 33.77, longitude: -84.41)
    let regionRadius: CLLocationDistance = 3000
    var locationsList = [Location]()
    var filter = ["Hospitals", "Sheters"]
    var selectedFilters = [false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = buttonItem
        startUpdatingLocation()
        initializeFetchedResultsController()
        
//        self.locationsList = self.getData()
//        self.addMapLocations()
//        self.collectionView.reloadData()
        
        if isConnectedToNetwork(){
            getLocations(type: 1)
            getLocations(type: 0)
        }else{
            self.locationsList = self.getData()
            self.addMapLocations()
            self.collectionView.reloadData()
        }
        self.filterScreen.isHidden = true
        self.tableHeight.constant = CGFloat(44 + 44 * filter.count)
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissFilter))
        tapper.cancelsTouchesInView = false
        filterScreen.addGestureRecognizer(tapper)
    }

    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpLocation")
        let nameSort = NSSortDescriptor(key: "locationName", ascending: true)
        request.sortDescriptors = [nameSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }

    @IBAction func filterTouch(_ sender: Any) {
        self.filterScreen.isHidden = false
        self.tableView.reloadData()
        self.view.bringSubview(toFront: filterScreen)
    }
    
    @objc func dismissFilter(){
        filterScreen.isHidden = true
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "Identifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            let loc = annotation as! Location
            annotationView.image = UIImage(named: loc.discipline)
            
        }
        return annotationView
    }
    
    //MARK:- LocationManagerDelegate Methods
    override func locationDidUpdate(_ location: CLLocation) {
        super.locationDidUpdate(location)
        initialLocation = CLLocation(latitude: 33.77, longitude: -84.41)
        centerMapOnLocation(location: initialLocation)
        
        LM.instance.locationManager.stopUpdatingLocation()
    }

    @IBAction func recenter(_ sender: Any) {
        let coordinate = CLLocationCoordinate2D(latitude: 33.77, longitude: -84.41)
        mapView.setCenter(coordinate, animated: true)
        //mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationDetailsCell", for: indexPath) as! LocationDetailsCell
        cell.config(loc: locationsList[indexPath.row], initialLocation: initialLocation)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterHeaderCell") as! FilterCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterCell
        cell.config(title:filter[indexPath.row], isSelected: selectedFilters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilters[indexPath.row] = !selectedFilters[indexPath.row]
        self.filterScreen.isHidden = true
        
        var predicates = [NSPredicate]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpLocation")
        for (index,item) in selectedFilters.enumerated(){
            if item{
                let type = index == 0 ? "hospitals" :  "shelters"
                predicates += [NSPredicate(format: "%K = %@", "discipline", type)]
            }
        }
        if predicates.count > 1{
            let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicates[0],predicates[1]])
            fetchRequest.predicate = predicateCompound
            
            let filteredData = try! fetchedResultsController!.managedObjectContext.fetch(fetchRequest)
            locationsList = getFilteredData(fetched: filteredData)
        }else{
            fetchRequest.predicate = predicates[0]
            let filteredData = try! fetchedResultsController!.managedObjectContext.fetch(fetchRequest)
            locationsList = getFilteredData(fetched: filteredData)
        }
        collectionView.reloadData()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func clearSelectedFilters() {
        selectedFilters = selectedFilters.map { _ in false }
        print(selectedFilters)
    }
    
    func addMapLocations(list: [Location] = [Location]()){
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        mapView.addAnnotations(locationsList)
    }
    
    func getData() -> [Location]{
        var loc = [Location]()
        if let fc = fetchedResultsController{
            for item in fc.fetchedObjects!{
                loc += [Location(loc: item as! HelpLocation)]
            }
        }
        return loc
    }
    
    func getFilteredData(fetched: [Any]) -> [Location]{
        var loc = [Location]()
        for item in fetched{
            loc += [Location(loc: item as! HelpLocation)]
        }
        
        return loc
    }
    
    func saveData(list:[Location]){
        for loc in list{
            if !isExist(loc: loc){
                // Create a new Location... and Core Data takes care of the rest!
                let helpLoc = HelpLocation(loc: loc, context: fetchedResultsController!.managedObjectContext)
//                print("Just created a location: \(helpLoc)")
            }
        }
        try! fetchedResultsController!.managedObjectContext.save()
        
    }
    
    func isExist(loc: Location) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HelpLocation")
        let predicate1 = NSPredicate(format: "lat == \(loc.coordinate.latitude)")
        let predicate2 = NSPredicate(format: "lng == \(loc.coordinate.longitude)")
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
        fetchRequest.predicate = predicateCompound
        
        let res = try! fetchedResultsController!.managedObjectContext.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    @IBAction func refreshTouch(_ sender: Any) {
        if isConnectedToNetwork(){
            getLocations(type: 1)
            getLocations(type: 0)
        }
    }
    
    func getLocations(type:Int = 0){
        let initialCoords = self.initialLocation.coordinate
        let locRequest = LocationsRequest(id: type, lat: initialCoords.latitude, lng: initialCoords.longitude)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        showLoadingIndicator()
        RequestSender().sendRequest(locRequest, success: { (response) in
            self.hideLoadingIndicator()
            let locResponse = response as! LocationsResponse
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //self.addMapLocations(list: locResponse.locations)
            //self.locationsList += locResponse.locations
            self.saveData(list: locResponse.locations)
            self.locationsList = self.getData()
            self.addMapLocations()
            self.collectionView.reloadData()
            //self.collectionView.reloadData()
        }) { (error) in
            self.hideLoadingIndicator()
            print("Error : ")
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(error)
            
        }
    }
    
    

}

extension MapController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
//        let set = IndexSet(integer: sectionIndex)
//
//        switch (type) {
//        case .insert:
//            tableView.insertSections(set, with: .fade)
//        case .delete:
//            tableView.deleteSections(set, with: .fade)
//        default:
//            // irrelevant in our case
//            break
//        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
//        switch(type) {
//        case .insert:
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
//        case .update:
//            tableView.reloadRows(at: [indexPath!], with: .fade)
//        case .move:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
//        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
    }
}
