//
//  CustomAnnotationView.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import Foundation
import MapKit
/**
 The purpose of the `CustomAnnotationView` is used to have custom annotation to place it on the mapview
 */
 class CustomAnnotationView: MKAnnotationView {
    /// Overrriding the initializer with having callout property
    public override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.canShowCallout = true
    }
    /// Required initializer for the coder and decoder
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
