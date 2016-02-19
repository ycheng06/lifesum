//
//  ViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoadJSONToCoreDelegate {
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LoadFromJSON.sharedInstance.initialLoad(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataLoaded(type: String) {
        print("all data loaded: " + type)
    }

}

