//
//  BaseViewController.swift
//  Branch Locator
//
//  Created by Vinay Shivanna on 10/28/17.
//  Copyright © 2017 Vinay Shivanna. All rights reserved.
//

import UIKit

/**
 The purpose of the `BaseViewController` view controller is to provide common basic implementation.
 
 - This contains all the common features which is required for all ViewControllers.
 
 - This class will be super class of all ViewController.
 
 The `BaseViewController` class is a subclass of the `UIViewController`.
 */
class BaseViewController: UIViewController {
    /**
     This method is called after the view controller has loaded its view hierarchy into memory. You usually override this method to perform additional initialization on views that were loaded from nib files.
     
     - Add styling for all views
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
