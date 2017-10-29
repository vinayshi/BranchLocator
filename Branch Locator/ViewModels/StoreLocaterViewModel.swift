//
//  StoreLocaterViewModel.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import Foundation
import LocatorLibrary
/**
 The purpose of the `StoreLocaterViewModel` is to get the data from the Model and also the response from model and Update the UI
 */
protocol StoreLocaterViewModelDelegate: class {
    func didReceiveStoresList()
}

class StoreLocaterViewModel: NSObject {
    
    weak var storesListDelegate:StoreLocaterViewModelDelegate?
    /// StoreList to update the store when we have response from the server
    var storesList: [StoreLocations] = [StoreLocations](){
        didSet{
            storesListDelegate?.didReceiveStoresList()
        }
    }
    /// Initialization for the view model to be setup
    override init() {
        super.init()
        LocationManager.sharedInstance.getCurrentLocation { (location, error) in
            print(location?.coordinate ?? "")
            let coordinatesModel = CoordinatesModel(longitude: (location?.coordinate.longitude)!, latitude: (location?.coordinate.latitude)!)
            let requestModel = StoreFinderRequestModel(coordinateModel: coordinatesModel)
            ServicesHandler.getStoresList(requestModel: requestModel, delegate: self)
        }
    }
}
/// Base Service Protocols are been implemented based on the response received
extension StoreLocaterViewModel: BaseServiceProtocol{
    func didRecieveResponseWithCompletion(serviceIdentifier: ServiceIdentifierEnum, responseData: Data) {
        print(Utilities.convertToArray(data: responseData) ?? "")
        if serviceIdentifier == .storeLocater {
            if let storesLists = try? JSONDecoder().decode(StoreFinderResponseModel.self, from: responseData) {
                print("Response : \(storesLists)")
                self.storesList = storesLists.locations!
            }
        }
    }
    /// Base Service Protocols are been implemented based on the error
    func didFailWithError(serviceIdentifier: ServiceIdentifierEnum, error: Error) {
        print(error.localizedDescription)
    }
}
