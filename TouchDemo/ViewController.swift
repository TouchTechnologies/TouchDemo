//
//  ViewController.swift
//  TouchDemo
//
//  Created by weerapons suwanchatree on 8/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ProximityContentManagerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var proximityContentManager: ProximityContentManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.activityIndicator.startAnimating()
        
        self.proximityContentManager = ProximityContentManager(
            beaconIDs: [
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE01", major: 4225, minor: 21861), //mint
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE02", major: 62648, minor: 16128),//ice
                BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE03", major: 20999, minor: 49007) //blueberry
            ],
            beaconContentFactory: CachingContentFactory(beaconContentFactory: BeaconDetailsCloudFactory()))
        self.proximityContentManager.delegate = self
        self.proximityContentManager.startContentUpdates()
    }
    
    func proximityContentManager(proximityContentManager: ProximityContentManager, didUpdateContent content: AnyObject?) {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
        
        if let beaconDetails = content as? BeaconDetails {
            self.view.backgroundColor = beaconDetails.backgroundColor
            self.label.text = "You're in \(beaconDetails.beaconName)'s range!"
            self.image.hidden = false
            
            let alertTitle = "Found Beacon"
            var alertMessage = ""
            
            switch beaconDetails.beaconName {
            case "mint":
                alertMessage = "This is \(beaconDetails.beaconName)"
            case "ice":
                alertMessage = "This is \(beaconDetails.beaconName)"
            case "blueberry":
                alertMessage = "This is \(beaconDetails.beaconName)"
            default:
                break
                
            }
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.view.backgroundColor = BeaconDetails.neutralColor
            self.label.text = "No beacons in range."
            self.image.hidden = true
        }
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

