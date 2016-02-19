//
//  ViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LoadJSONToCoreDelegate {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
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
            loadingIndicator.startAnimating()
            categoryButton.enabled = false
            categoryButton.alpha = 0.25
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
            categoryButton.alpha = 1
            
            loadingIndicator.stopAnimating()
            loadingIndicator.hidden = true
        }
    }

}

