//
//  Branch_LocatorTests.swift
//  Branch LocatorTests
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import XCTest
import MapKit

@testable import Branch_Locator

class Branch_LocatorTests: XCTestCase {
    var vc: StoreLocaterViewController!
    var locationManager:CLLocationManager =  CLLocationManager()
    var currentLocation:CLLocation = CLLocation()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateViewController(withIdentifier: "StoreLocaterViewController") as! StoreLocaterViewController
        let _ = vc.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testViewDidLoad(){
        XCTAssertNotNil(vc.viewDidLoad())
    }
    
    func testViewControllerIsComposedOfMapView() {
        XCTAssertNotNil(vc.mapView, "ViewController under test is not composed of a MKMapView")
    }
    
    func testMapViewDelegateIsSet() {
        XCTAssertNotNil(self.vc.mapView.delegate)
    }
    func testMapViewuseMyLocation() {
        XCTAssertNotNil(self.vc.useMyLocation())
    }
    func testAddRadiusCircle() {
        XCTAssertNotNil(self.vc.addRadiusCircle(location: currentLocation))
    }
    
    func testControllerImplementsMKMapViewDelegateMethods() {
        XCTAssertTrue(vc.responds(to: #selector(StoreLocaterViewController.mapView(_:viewFor:))),"ViewController under test does not implement mapView:viewForAnnotation")
    }
    
    func testMapViewCanRenderPolygonByImplementingMapViewRendererForOverlay() {
        XCTAssert(self.vc.responds(to: #selector(StoreLocaterViewController.mapView(_:rendererFor:))))
    }
    
    func hasTargetAnnotation(annotationClass: MKAnnotation.Type) -> Bool {
        let mapAnnotations = self.vc.mapView.annotations
        var hasTargetAnnotation = false
        for anno in mapAnnotations {
            if (anno.isKind(of: annotationClass)) {
                hasTargetAnnotation = true
            }
        }
        return hasTargetAnnotation
    }
    func testMapViewCanRenderPolygonByImplementingMapViewRendererForOverlay1() {
        XCTAssert(self.vc.responds(to: #selector(MKMapViewDelegate.mapView(_:rendererFor:))))
    }
    func testService() {
        
    }
}
