//
//  ViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoadJSONToCoreDelegate {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var exerciseButton: UIButton!
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // check if app already launched once
        let defaults = NSUserDefaults.standardUserDefaults()
        let launchedOnce:Bool = defaults.boolForKey("appAlreadyLaunchedOnce")
        if !launchedOnce {
            // disable buttons. wait for callback to able them
            categoryButton.enabled = false
            exerciseButton.enabled = false
        }
        
        LoadFromJSON.sharedInstance.initialLoad(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataLoaded(type: String) {

        if type == "exercise" {
            print("all data loaded: " + type)
            self.exerciseButton.enabled = true
        }
        else if type == "food" {
            print("all data loaded: " + type)

            categoryButton.enabled = true
        }
    }

}

