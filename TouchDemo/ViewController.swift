//
//  ViewController.swift
//  TouchDemo
//
//  Created by weerapons suwanchatree on 8/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, ProximityContentManagerDelegate {

//    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var image: UIImageView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var alert = SweetAlert()
    var proximityContentManager: ProximityContentManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        design()
        
//        self.activityIndicator.startAnimating()
        
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
//        self.activityIndicator?.stopAnimating()
//        self.activityIndicator?.removeFromSuperview()
        
        if let beaconDetails = content as? BeaconDetails {
//            self.view.backgroundColor = beaconDetails.backgroundColor
//            self.label.text = "You're in \(beaconDetails.beaconName)'s range!"
//            self.image.hidden = false
            
            let alertTitle = "Found Beacon"
            var alertMessage = ""
            
            switch beaconDetails.beaconName {
            case "mint":
                 self.alert.dismissViewControllerAnimated(true, completion: nil)
                alertMessage = "This is \(beaconDetails.beaconName)"
            case "ice":
                 self.alert.dismissViewControllerAnimated(true, completion: nil)
                alertMessage = "This is \(beaconDetails.beaconName)"
            case "blueberry":
                 self.alert.dismissViewControllerAnimated(true, completion: nil)
                alertMessage = "This is \(beaconDetails.beaconName)"
            default:
                break
                
            }
//            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
            alert.showAlert(alertTitle, subTitle: alertMessage, style: AlertStyle.Warning, buttonTitle:"Cancel", buttonColor:UIColor.redColor() , otherButtonTitle:  "Yes, delete it!", otherButtonColor: UIColor.blueColor()) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    self.alert.dismissViewControllerAnimated(true, completion: nil)
                    print("Cancel Button  Pressed")
                }
                else {
                    SweetAlert().showAlert("Deleted!", subTitle: "Your imaginary file has been deleted!", style: AlertStyle.Success)
                }
            }
            
        } else {
//            self.view.backgroundColor = BeaconDetails.neutralColor
//            self.label.text = "No beacons in range."
//            self.image.hidden = true
        }
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //----------  View Set  -----------
    lazy var  viewMainbackground = UIView()
    lazy var  viewTitleBox = UIView()
    lazy var  viewDescriptionBox = UIView()
    //---------------------------------
    
    //----------  Image Set  ----------
    lazy var  imgBackground = UIImageView()
    lazy var  imgCircle = UIImageView()
    //let imgCircle1 = UIImageView()
    //let imgCircle2 = UIImageView()
    //let imgCircle3 = UIImageView()
    lazy var  imgTitleText = UIImageView()
    lazy var  imgDescriptionText = UIImageView()
    //---------------------------------
    
    //----------  Label Set  ----------
    lazy var  lblBottom = UILabel()
    //---------------------------------
    
    func design() {
        
        let frmView = self.view.frame
        
//        let frmMainbackground = CGRectMake(0, 0, frmView.size.width, frmView.size.width)
//        viewMainbackground.frame = frmMainbackground
      
        
//        let titleBoxSize = frmView.size.width - 50
//        let frmTitleBox = CGRectMake(25, 40, titleBoxSize, titleBoxSize)
//        viewTitleBox.frame = frmTitleBox
        
        
        
        
        
        
        viewMainbackground.backgroundColor = UIColor.greenColor()
        viewTitleBox.backgroundColor = UIColor.blueColor()
        viewDescriptionBox.backgroundColor = UIColor.yellowColor()
        
        
        
        
        
        
        
        
        self.viewMainbackground.addSubview(imgBackground)
        self.viewTitleBox.addSubview(imgCircle)
        self.viewTitleBox.addSubview(imgTitleText)
        self.viewDescriptionBox.addSubview(imgDescriptionText)
        
        self.view.addSubview(viewMainbackground)
        self.view.addSubview(viewTitleBox)
        self.view.addSubview(viewDescriptionBox)
        
        
        //-- -- -- -- -- -- -- -- -- -- --
        
        
        viewMainbackground.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        
        let titleBoxSize = frmView.size.width - 50
        viewTitleBox.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(45)
//            make.width.equalTo(titleBoxSize)
//            make.height.equalTo(titleBoxSize)
            make.size.equalTo(CGSizeMake(titleBoxSize, titleBoxSize))
//            make.left.equalTo(0)
//            make.bottom.equalTo(0)
//            make.right.equalTo(0)
            make.center.equalTo(viewMainbackground)
        }

        
//        viewDescriptionBox.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(viewTitleBox).offset(20)
//            make.top.equalTo(0)
//            make.left.equalTo(0)
//            make.bottom.equalTo(0)
//            make.right.equalTo(0)
//        }
//        
        
    }
}

