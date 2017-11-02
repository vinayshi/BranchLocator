//
//  ViewController.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import UIKit
import MapKit
import LocatorLibrary
/**
 The purpose of the `StoreLocaterViewController` view controller is to display the stores in the MapView
 */
class StoreLocaterViewController: BaseViewController {
    /// Mapview to display the map
    @IBOutlet weak var mapView: MKMapView!
    /// To get the current location
    @IBOutlet weak var useMyLocationButton: UIButton!
    /// View model of the Store Locator
    var viewModel:StoreLocaterViewModel?
    /// annotations to display on the mapview
    var annotations = [MKPointAnnotation]()

    /**
     This method is called after the view controller has loaded its view hierarchy into memory. You usually override this method to perform additional initialization on views that were loaded from nib files.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locator"
        viewModel = StoreLocaterViewModel()
        viewModel?.storesListDelegate = self as StoreLocaterViewModelDelegate
        mapView.delegate = self
        let searchRightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let searchRightImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: searchRightView.frame.size.width - 10, height: searchRightView.frame.size.height - 10))
        searchRightImageView.image = UIImage(named: "storeSearchIcon")
        searchRightView.addSubview(searchRightImageView)
        useMyLocationButton.addTarget(self, action: #selector(useMyLocation), for: .touchUpInside)
    }
    /// This method will fetch the user s current location
    @objc func useMyLocation() {
        LocationManager.sharedInstance.getCurrentLocation { (location, error) in
            print(location?.coordinate ?? "")
            LocationManager.sharedInstance.enableLocationManager()
            
            let currentLocation = location 
            
            let center = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            
            self.mapView.setRegion(region, animated: true)
            self.addRadiusCircle(location: location!)
        }
    }
    /// Adding the circle based on the user current location
    func addRadiusCircle(location: CLLocation){
            self.mapView.delegate = self
            let circle = MKCircle(center: location.coordinate, radius: 1500)
            self.mapView.add(circle)
    }
    /// Rendering the circle based on the user current location
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        } else {
            return MKPolylineRenderer()
        }
    }
}
/// StoreLocaterViewModelDelegate : Implementing the delegate methods, when store list from the service
extension StoreLocaterViewController: StoreLocaterViewModelDelegate {
    func didReceiveStoresList() {
        addAnnotationsForMapView(storesList: viewModel!.storesList)
    }
}
/// Implementing the delegate methods of the Mapview
extension StoreLocaterViewController: MKMapViewDelegate {
    /// viewForAnnotation is for displaying the annotations on the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: CustomAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? CustomAnnotationView {
            annotationView = dequeuedAnnotationView
        }else {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        annotationView?.image = UIImage(named: "ATM")
        if let annotationIndex = Int(annotation.title!!){
            let storeDetails = viewModel?.storesList[annotationIndex]
            annotationView?.canShowCallout = true
            let label:UILabel  = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: 120, height: 70))
            label.numberOfLines = 0;
            label.adjustsFontSizeToFitWidth = true
            label.text = storeDetails?.name
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.textAlignment = .natural
            annotationView?.leftCalloutAccessoryView = label
            let calloutButton = UIButton(type: .detailDisclosure) as UIButton
            annotationView!.rightCalloutAccessoryView = calloutButton
        }
        return annotationView
    }
    /// calloutAccessoryControlTapped is for tapping on the accessory button in the accessory view
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            print("button tapped")
            let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: StoreLocatorDetailsViewController.self)) as! StoreLocatorDetailsViewController
                detailsVC.viewModel = viewModel
                detailsVC.annotationView = view
                self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    /// Removing the annotationd from the mapview
    func removeTheAnnotionsFromMapView(){
        annotations.removeAll()
        for annotation in mapView.annotations {
            self.mapView.removeAnnotation(annotation)
        }
    }
    /// Adding the annotations to the mapview when we the stores list
    func addAnnotationsForMapView(storesList:[StoreLocations]){
        removeTheAnnotionsFromMapView()
        for (index,storeDetails) in storesList.enumerated(){
            let latitude = CLLocationDegrees(Double(storeDetails.lat!) ?? 0)
            let longitude = CLLocationDegrees(Double(storeDetails.lng!) ?? 0)
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.title = String(index)
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        showMapViewAnnotations(annotations: annotations)
    }
    /// Showing the annotions on the mapview within the Point
    func showMapViewAnnotations(annotations: [MKPointAnnotation]){
        if let firstAnnotation = annotations.first {
            var minPoint: MKMapPoint = MKMapPointForCoordinate(firstAnnotation.coordinate)
            var maxPoint: MKMapPoint = minPoint
            for annotation: MKAnnotation in annotations {
                let point: MKMapPoint = MKMapPointForCoordinate(annotation.coordinate)
                if point.x < minPoint.x {
                    minPoint.x = point.x
                }
                if point.y < minPoint.y {
                    minPoint.y = point.y
                }
                if point.x > maxPoint.x {
                    maxPoint.x = point.x
                }
                if point.y > maxPoint.y {
                    maxPoint.y = point.y
                }
                mapView.addAnnotation(annotation)
            }
            let mapRect: MKMapRect = MKMapRectMake(minPoint.x, minPoint.y, maxPoint.x - minPoint.x, maxPoint.y - minPoint.y)
            
            let edgePadding: UIEdgeInsets = UIEdgeInsetsMake(50, 15, 50, 15)
            mapView.setVisibleMapRect(mapRect, edgePadding: edgePadding, animated: true)
        }
    }
}
