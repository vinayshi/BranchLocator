//
//  StoreFinderModel.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import Foundation
import LocatorLibrary
/**
 The purpose of the `StoreFinderModel` is to have the Request Model and Resposne Model
 */
/// StoreFinderRequestModel  have the coordiantes which is mapped with CoordinatesModel
class StoreFinderRequestModel:Serializable {
    var coordinateModel: CoordinatesModel?
    
    init(coordinateModel:CoordinatesModel) {
        self.coordinateModel = coordinateModel
    }
}
/// CoordinatesModel model have latitiude and longitude
class CoordinatesModel:Codable {
    /// longitude to used to get the current location
    var longitude: Double?
    /// latitude to used to get the current location
    var latitude: Double?
    
    init(longitude:Double, latitude:Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
/// StoreFinderResponseModel for the Store locator Response model
class StoreFinderResponseModel:Serializable {
    /// location to have the all location  details from the APi
    var locations: [StoreLocations]?
}
/// StoreLocations with the list of all the location details
class StoreLocations: Serializable {
    /// parameter state to used to display in location details
    var state: String?
    /// parameter loc type to used to display in location details
    var locType: String?
    /// parameter address to used to display in location details
    var address: String?
    /// parameter city to used to display in location details
    var city: String?
    /// parameter zip to used to display in location details
    var zip: String?
    /// parameter name to used to display in location details
    var name: String?
    /// parameter lat to used to display placemark in map
    var lat: String?
    /// parameter lat to used to display placemark in map
    var lng: String?
    /// parameter name to used to bank in location details
    var bank: String?
    /// parameter name to used to atms in location details
    var atms: Double!
    /// parameter name to used to phone in location details
    var phone: String?
    /// parameter name to used to distance in location details
    var distance: Double!
}

