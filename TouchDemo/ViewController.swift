//
//  ViewController.swift
//  TouchDemo
//
//  Created by weerapons suwanchatree on 8/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import SnapKit
import KDCycleBannerView
import AudioToolbox

class ViewController: UIViewController, ProximityContentManagerDelegate, KDCycleBannerViewDataource, KDCycleBannerViewDelegate {

//    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var image: UIImageView!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var alert = SweetAlert()
    var proximityContentManager: ProximityContentManager!
    
    
    var bannerIsShow = false
    var bannerSet = 0
    
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
        
        
        frmView = self.view.frame
        design()
        initBanner()
        
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
            
            GlobalVariables.sharedManager.bannerIsShow = true
            bannerIsShow = true
            
            switch beaconDetails.beaconName {
            case "mint":
                if(bannerSet != 1 && viewAlert.alpha >= 1 ){
                    print("Close 'Mint' and Open \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 1
                    bannerSet = 1
                    closeBanner(true)
                }else{
                    print("sayHello 'Mint' \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 1
                    bannerSet = 1
                    sayHello()
                }
            case "blueberry":
                 if(bannerSet != 2 && viewAlert.alpha >= 1 ){
                    print("Close 'Blueberry' and Open \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 2
                    bannerSet = 2
                    closeBanner(true)
                 }else{
                    print("sayHello 'Blueberry' \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 2
                    bannerSet = 2
                    sayHello()
                }
            case "ice":
                 if(bannerSet != 3 && viewAlert.alpha >= 1 ){
                    print("Close 'Ice' and Open \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 3
                    bannerSet = 3
                    closeBanner(true)
                 }else{
                    print("sayHello 'Ice' \(beaconDetails.beaconName)")
                    
                    GlobalVariables.sharedManager.bannerSet = 3
                    bannerSet = 3
                    sayHello()
                }
            default:
                break
                
            }
        } else {
            
            var bName = ""
            if let c = content as? BeaconDetails {
                bName = c.beaconName
            }
            print("Close \(bName)")
            
            GlobalVariables.sharedManager.bannerIsShow = false
            GlobalVariables.sharedManager.bannerSet = 0
            bannerIsShow = false
            bannerSet = 0
            
            closeBanner()
        }
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.getActionStatus), userInfo: nil, repeats: true)
    }
    
    
//    func getActionStatus() {
//        
////        var bannerIsShow = false
//        //        var bannerSet = 0
//        
//        
//        let bannerIsShow = GlobalVariables.sharedManager.bannerIsShow
//        let bannerSet = GlobalVariables.sharedManager.bannerSet
//        
//        
//        print("Display Action")
//        print("bannerIsShow = \((bannerIsShow ? "show" : "hide"))")
//        print("bannerSet = \(bannerSet)")
//        print("----------------------")
//        
//        
//    }

    func sayHello() {
        
        viewBanner.reloadDataWithCompleteBlock({a in
            if(self.viewAlert.alpha != 1){
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
            UIView.animateWithDuration(0.2, animations: {
                
                self.viewAlertBg.hidden = false
                self.viewAlertBg.alpha = 0.9
                
                self.viewAlert.hidden = false
                self.viewAlert.alpha = 1
                
                
                //print("sayHello xxxx!")
                
                }, completion:{_action in
                    
                    //print("sayHello zzzzzz!")
                    
                    
            })
        })
        
        
    }
    
    func closeBanner(andOpenDelay:Bool = false) {
        UIView.animateWithDuration(0.2, animations: {
            
            self.viewAlertBg.hidden = false
            self.viewAlertBg.alpha = 0
            
            self.viewAlert.hidden = false
            self.viewAlert.alpha = 0
            
            
            //print("sayHello xxxx!")
            
            }, completion:{_action in
                
                //print("sayHello zzzzzz!")
                self.viewAlert.hidden = true
                self.viewAlertBg.hidden = true
                
                //sayHello()
                if(andOpenDelay){
                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.sayHello), userInfo: nil, repeats: false)
                }
        })
    }
    
    func numberOfKDCycleBannerView(bannerView: KDCycleBannerView!) -> [AnyObject]! {
        
//        bannerIsShow = false
//        bannerSet = 0
        if (bannerSet == 1){
            return [
                UIImage(named: "ib_L_p1")!,
                UIImage(named: "ib_L_p2")!
            ]
        }else if (bannerSet == 2){
            return [
                UIImage(named: "ib_r_p1")!,
                UIImage(named: "ib_r_p2")!
            ]
        }else if (bannerSet == 3){
            return [
                UIImage(named: "smart_p1")!,
                UIImage(named: "smart_p2")!,
                UIImage(named: "smart_p3")!
            ]
        }else{
            return [
                UIImage(named: "ib_L_p1")!,
                UIImage(named: "ib_L_p2")!
            ]
        }
        
    }
    
    func contentModeForImageIndex(index: UInt) -> UIViewContentMode {
        return .ScaleAspectFit
    }
    
    func placeHolderImageOfZeroBannerView() -> UIImage! {
        return UIImage(named: "bg")!
    }
    
    func initBanner() {
        
        viewAlertBg.hidden = true
        viewAlertBg.alpha = 0
        viewAlertBg.backgroundColor = UIColor.blackColor()
        
        viewAlert.hidden = true
        viewAlert.alpha = 0
        //viewAlert.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(viewAlertBg)
        self.view.addSubview(viewAlert)
        viewAlert.addSubview(viewBanner)
        viewAlert.addSubview(btnCloseBanner)
        
        //-- -- -- -- -- -- -- -- -- -- --
        
        //btnCloseBanner.backgroundColor = UIColor.whiteColor()
        btnCloseBanner.addTarget(self, action: #selector(ViewController.closeBanner), forControlEvents: .TouchUpInside)
        
        btnCloseBanner.imageView?.contentMode = .Center
        btnCloseBanner.setImage(UIImage(named: "close"), forState: .Normal)
        
//        let alertBoxWidth = frmView.size.width
//        let alertBoxHeight = frmView.size.height
        viewAlert.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(self.view)
            make.center.equalTo(self.view)
            //make.center.equalTo(self.frmView.size).offset(CGPointMake(0, -100))
        }
        
        viewAlertBg.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(viewAlert)
            make.center.equalTo(viewAlert)
        }
        
        btnCloseBanner.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(40,40))
            make.top.equalTo(30)
            make.right.equalTo(btnCloseBanner.frame.size.width - 10)
            //make.right.equalTo(viewAlert).offset(-50)
            //make.center.equalTo(self.frmView.size).offset(CGPointMake(0, -100))
        }
        //-- -- -- -- -- -- -- -- -- -- --
        
        //viewBanner = KDCycleBannerView()
        viewBanner.frame = frmView;
        viewBanner.datasource = self;
        viewBanner.delegate = self;
        viewBanner.continuous = true;
        viewBanner.autoPlayTimeInterval = 5;
        
        
        let alertBannerWidth = frmView.size.width - 20
        let alertBannerHeight = frmView.size.height - 20
        viewBanner.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(alertBannerWidth, alertBannerHeight))
            make.center.equalTo(viewAlert)
        }
        
    }
    
    var frmView = CGRect()
    //----------  View Alert Set  -----------
    
    lazy var viewAlertBg = UIView()
    lazy var viewAlert = UIView()
    lazy var btnCloseBanner = UIButton()
    let viewBanner = KDCycleBannerView()
    lazy var imgCloseButton = UIImageView()
    
    //---------------------------------

    
    //----------  View Set  -----------
    lazy var viewMainbackground = UIView()
    lazy var viewTitleBox = UIView()
    lazy var viewDescriptionBox = UIView()
    //---------------------------------
    
    //----------  Image Set  ----------
    lazy var imgBackground = UIImageView()
    lazy var imgCircle = UIImageView()
    //let imgCircle1 = UIImageView()
    //let imgCircle2 = UIImageView()
    //let imgCircle3 = UIImageView()
    lazy var imgTitleText = UIImageView()
    lazy var imgDescriptionText = UIImageView()
    //---------------------------------
    
    //----------  Label Set  ----------
    lazy var  lblBottom = UILabel()
    //---------------------------------
    
    func design() {
        
        
//        let frmMainbackground = CGRectMake(0, 0, frmView.size.width, frmView.size.width)
//        viewMainbackground.frame = frmMainbackground
      
        
//        let titleBoxSize = frmView.size.width - 50
//        let frmTitleBox = CGRectMake(25, 40, titleBoxSize, titleBoxSize)
//        viewTitleBox.frame = frmTitleBox
        
        
        
        
        
        
//        viewMainbackground.backgroundColor = UIColor.greenColor()
//        viewTitleBox.backgroundColor = UIColor.blueColor()
//        viewDescriptionBox.backgroundColor = UIColor.yellowColor()
        
        
        
        
        
        
        
        //------
        
        
        
        
        imgBackground.image = UIImage(named: "bg")
        imgBackground.contentMode = .ScaleAspectFill
        
        imgCircle.image = UIImage(named: "circle")
        imgCircle.contentMode = .ScaleAspectFit
        //imgCircle.backgroundColor = UIColor.redColor()
        
        imgTitleText.image = UIImage(named: "logo")
        imgTitleText.contentMode = .ScaleAspectFit
        //imgTitleText.backgroundColor = UIColor.greenColor()
        
        imgDescriptionText.image = UIImage(named: "smart_logo")
        imgDescriptionText.contentMode = .ScaleAspectFit
        
//        lblBottom.backgroundColor = UIColor.blueColor()
//        lblBottom.alpha = 0.5
        lblBottom.text = "Use your phone to locate any iBeacons around you"
        lblBottom.textAlignment = .Center
        lblBottom.font.fontWithSize(14)
        lblBottom.adjustsFontSizeToFitWidth = true
        lblBottom.minimumScaleFactor = 0.2
        
        self.viewMainbackground.addSubview(imgBackground)
        self.viewTitleBox.addSubview(imgCircle)
        self.viewTitleBox.addSubview(imgTitleText)
        self.viewDescriptionBox.addSubview(imgDescriptionText)
        
        self.view.addSubview(viewMainbackground)
        self.view.addSubview(viewTitleBox)
        self.view.addSubview(viewDescriptionBox)
        self.view.addSubview(lblBottom)
        
        
        
        
        //-- -- -- -- -- -- -- -- -- -- --
        
        viewMainbackground.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        let titleBoxSize = frmView.size.width - 60
        viewTitleBox.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(74)
            make.size.equalTo(CGSizeMake(titleBoxSize, titleBoxSize))
            make.centerX.equalTo(viewMainbackground)
        }
        
        let DesBoxSize = frmView.size.width - 120
        viewDescriptionBox.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(DesBoxSize, DesBoxSize))
            make.top.equalTo(viewTitleBox).offset(titleBoxSize - 90)
            make.centerX.equalTo(viewMainbackground)
        }
        
        //------
        imgBackground.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        let imgTitleBoxSize = frmView.size.width - 80
        imgCircle.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(imgTitleBoxSize, imgTitleBoxSize))
            make.center.equalTo(viewTitleBox)
        }
        
        let imgTitleTextSize = frmView.size.width - 50
        imgTitleText.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(imgTitleTextSize, imgTitleTextSize))
            make.center.equalTo(viewTitleBox)
        }
        
        imgDescriptionText.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(DesBoxSize, DesBoxSize))
            make.center.equalTo(viewDescriptionBox)
        }
        
        lblBottom.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(self.view.frame.size.width - 20, 40))
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(0)
        }
    }
}

