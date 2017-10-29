//
//  StoreLocatorDetailsViewController.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/29/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import UIKit
import MapKit
import LocatorLibrary
/**
 The purpose of the `StoreLocatorDetailsViewController` view controller is to display the  store details and also the directions from the current location
 */
class StoreLocatorDetailsViewController: BaseViewController {
    /// viewmodel to fetch the selected location
    var viewModel:StoreLocaterViewModel?
    /// store location details to display on details screen
    var storeLocationDetails: StoreLocations?
    /// annotation view to get the annotation
    public var annotationView: MKAnnotationView?
    /// display the LobbyHours in store details screen
    @IBOutlet weak var storeLobbyHours: UILabel!
    /// display the distance in store details screen
    @IBOutlet weak var storeDistance: UILabel!
    /// display the ATM opening hours in store details screen
    @IBOutlet weak var storeATMOpeningHours: UILabel!
    /// display the No of ATMs in store details screen
    @IBOutlet weak var storeATM: UILabel!
    /// display the Phone number in store details screen
    @IBOutlet weak var storePhone: UILabel!
    /// display the City, State, zip in store details screen
    @IBOutlet weak var storeCityStateZip: UILabel!
    /// display the Address in store details screen
    @IBOutlet weak var storeAddress: UILabel!
    /// display the Name in store details screen
    @IBOutlet weak var storeName: UILabel!
    
    /**
     This method is called after the view controller has loaded its view hierarchy into memory. You usually override this method to perform additional initialization on views that were loaded from nib files.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Store Details"
        if let annotationIndex = Int(((annotationView?.annotation?.title)!)!) {
            storeLocationDetails = viewModel?.storesList[annotationIndex]
        }
        print("Store : \(String(describing: storeLocationDetails))")
        self.setUpData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /// This method is to display the store details from the view model store details
    func setUpData() {
        self.storeName.text = storeLocationDetails?.name
        self.storeAddress.text = storeLocationDetails?.address
        self.storeCityStateZip.text = (storeLocationDetails?.city)! + " " + (storeLocationDetails?.state)! + " " + (storeLocationDetails?.zip)!
        self.storePhone.text = storeLocationDetails?.phone
        self.storeATM.text = "Branch with \(String(format: "%.1f",(storeLocationDetails?.atms)!)) ATMs"
        self.storeATMOpeningHours.text = "ATM Open 24 Hours"
        self.storeLobbyHours.text = "Lobby Hours"
        self.storeDistance.text = String(format: "%.3f",(storeLocationDetails?.distance)!)
    }
    /// Directions from the current location to the selected store
    @IBAction func directionsTapped(_ sender: Any) {
        let placemark = MKPlacemark(coordinate: (annotationView?.annotation!.coordinate)!, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}
