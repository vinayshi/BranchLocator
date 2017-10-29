//
//  ServicesHandler.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import Foundation
import LocatorLibrary
/**
 The purpose of the `ServicesHandler` is identify the service which has request model, url to be passed to Base Service class
 */
class ServicesHandler {
    class func getStoresList(requestModel:StoreFinderRequestModel, delegate:BaseServiceProtocol){
        var storeLocaterTestURL = Utilities.getURLWith(key: "testStoreLocaterURL") ?? ""
        let latitude = (requestModel.coordinateModel?.latitude)!
        let longitude = (requestModel.coordinateModel?.longitude)!
        storeLocaterTestURL = storeLocaterTestURL + "lat=\(latitude)" + "&" + "lng=\(longitude)"
        let storesListService = BaseService(serviceIdentifier: .storeLocater, serviceType: .GET, serviceURL: storeLocaterTestURL, requestData: requestModel.serialize(), delegate: delegate)
        storesListService.start()
    }
}
