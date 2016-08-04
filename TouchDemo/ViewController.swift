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
    
    let timerForOpenAgain = 20
    
    var bannerIsShow = false
    var bannerSet = 0
    var lastClosedSet = 0
    
    var tmDisplay = 0
    
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)

    }
    
    func alert1() {
        
        print(" >>>>>>>>>>>>>>>> call func alert1() >>>>>>>>>>>>>>>> ")
        bannerSet = 1
        sayHello(bannerSet)
        
    }
    
    func alert2() {
        
        print(" >>>>>>>>>>>>>>>> call func alert2() >>>>>>>>>>>>>>>> ")
        bannerSet = 3
        sayHello(bannerSet)
        
    }
    
    func alert3() {
        
        print(" >>>>>>>>>>>>>>>> call func alert3() >>>>>>>>>>>>>>>> ")
        bannerSet = 2
        sayHello(bannerSet)
        
    }
    
    func alert4() {
        
        print(" >>>>>>>>>>>>>>>> call func alert4() >>>>>>>>>>>>>>>> ")
        bannerSet = 2
        sayHello(bannerSet)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        UIApplication.sharedApplication().statusBarStyle = .Default
        
        
        
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.alert1), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: #selector(ViewController.alert2), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(14.0, target: self, selector: #selector(ViewController.alert3), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(25.0, target: self, selector: #selector(ViewController.alert4), userInfo: nil, repeats: false)
        
        
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
                bannerSet = 1
            case "blueberry":
                bannerSet = 2
            case "ice":
                bannerSet = 3
            default:
                break
                
            }
            sayHello(bannerSet)
            
        } else {
            
//            var bName = ""
//            if let c = content as? BeaconDetails {
//                bName = c.beaconName
//            }
//            print("Close \(bName)")
            
//            GlobalVariables.sharedManager.bannerIsShow = false
//            GlobalVariables.sharedManager.bannerSet = 0
//            bannerIsShow = false
//            bannerSet = 0
            
            //closeBanner()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    var tmr:NSTimer = NSTimer()
    func tmTickTock() {
        
        self.tmDisplay = self.tmDisplay + 1
//        print("tmTickTock")
//        print("self.tmDisplay = \(self.tmDisplay)")
//        print("-------------------------------------")
        
    }
    
    func tmStop() {
        
        self.tmr.invalidate()
        //self.tmr = nil
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        tmStop()
    }

    func sayHello(bSet: Int = 0) {
        
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++")
//            print("++++++++++++++++++++++")
//            print("self.viewAlert.alpha = \(self.viewAlert.alpha)")
            print("self.lastClosedSet = \(self.lastClosedSet)")
            print("self.bannerSet = \(self.bannerSet)")
            print("self.tmDisplay = \(self.tmDisplay)")
        //            print("self.timerForOpenAgain = \(self.timerForOpenAgain)")
        
            if(self.viewAlert.alpha < 1){
                
                
                if(((self.lastClosedSet == self.bannerSet && self.tmDisplay > self.timerForOpenAgain)) || (self.lastClosedSet != self.bannerSet)){
                    
//                    self.tmDisplay = 0
//                    self.tmStop()
                    
                    bannerSet = bSet == 0 ? bannerSet : bSet
                    
                    viewBanner.reloadDataWithCompleteBlock({a in
                        
                        self.tmr.invalidate()
                        self.tmDisplay = 0
                        
                        print("++++++++ เปิดต่อไป +++++++++")
                        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        
                        self.viewBanner.setCurrentPage(0, animated: false)
                        
                        UIView.animateWithDuration(0.2, animations: {
                            
                            self.viewAlertBg.hidden = false
                            self.viewAlertBg.alpha = 0.9
                            
                            self.viewAlert.hidden = false
                            self.viewAlert.alpha = 1
                            
                            
                            //print("sayHello xxxx!")
                            
                            }, completion:{_action in
                                
                                //print("sayHello zzzzzz!")
                                self.lastClosedSet = bSet
                                
                        })
                        
                    })
                    
                }else{
                    
                    print("++++++++ รอเวลาเปิด +++++++++")
                    
                }
               
                
            }else{
                
                
                print("++++++++ ปิด +++++++++")
                self.closeBanner(true)
//                UIView.animateWithDuration(0.2, animations: {
//                    
//                    self.viewAlertBg.hidden = false
//                    self.viewAlertBg.alpha = 0
//                    
//                    self.viewAlert.hidden = false
//                    self.viewAlert.alpha = 0
//                    
//                    //print("sayHello xxxx!")
//                    
//                    }, completion:{_action in
//                        
//                        self.closeBanner(true)
//                        //NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.sayHello), userInfo: nil, repeats: false)
//                        
//                })
                
            }
        
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
    }
    
    func closeBanner(andOpenDelay:Bool = false) {
        
//        print("-------------------------")
//        print("self.viewAlert.alpha = \(self.viewAlert.alpha)")
//        print("self.lastClosedSet = \(self.lastClosedSet)")
//        print("self.bannerSet = \(self.bannerSet)")
//        print("self.tmDisplay = \(self.tmDisplay)")
//        print("self.timerForOpenAgain = \(self.timerForOpenAgain)")
        
        tmr = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.tmTickTock), userInfo: nil, repeats: true)
        //self.tmDisplay = 0
        lastClosedSet = bannerSet
        
        UIView.animateWithDuration(0.5, animations: {
            
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
                    print("---------------------------------------------------------------------")
                    NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.sayHello(_:)), userInfo: nil, repeats: false)
                }else{
                    print("---------------------------------------------------------------------")
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
        viewBanner.autoPlayTimeInterval = 8;
        
        
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

