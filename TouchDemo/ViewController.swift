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
import Pulsator

class ViewController: UIViewController, ProximityContentManagerDelegate, KDCycleBannerViewDataource, KDCycleBannerViewDelegate, UIGestureRecognizerDelegate {
    
    //    @IBOutlet weak var label: UILabel!
    //    @IBOutlet weak var image: UIImageView!
    //    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var alert = SweetAlert()
    var proximityContentManager: ProximityContentManager!
    
    let timerForOpenAgain = 5
    
    var bannerIsShow = false
    var bannerSet = 0
    var lastClosedSet = 0
    
    var tmDisplay = 0
    
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        
    }
    
    func alert1() {
        
        bannerSet = 1
        sayHello()
        
    }
    
    func alert2() {
        
        bannerSet = 3
        sayHello()
        
    }
    
    func alert3() {
        
        bannerSet = 2
        sayHello()
        
    }
    
    func alert4() {
        
        bannerSet = 2
        sayHello()
        
    }
    
    func setTestAction(sender: UIGestureRecognizer) {
        
        NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: #selector(ViewController.alert1), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(16.0, target: self, selector: #selector(ViewController.alert2), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(26.0, target: self, selector: #selector(ViewController.alert3), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(36.0, target: self, selector: #selector(ViewController.alert4), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(46.0, target: self, selector: #selector(ViewController.alert4), userInfo: nil, repeats: false)
        
        print("xxxxxxxx")
        
        
        let alertController = UIAlertController(title: "Start Test Action", message: "Waitng for alert", preferredStyle:UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { _ in
            print("you have pressed OK button");
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:{ () -> Void in
            //your code here
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //UIApplication.sharedApplication().statusBarStyle = .Default
        
        //longPress
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.setTestAction(_:)))
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        longPress.minimumPressDuration = 10
        self.view.addGestureRecognizer(longPress)
        
        frmView = self.view.frame
        design()
        initBanner()
        
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
            sayHello()
            
        } else {
            
            //closeBanner() // ไม่ต้องปิดแล้ว จนกว่าผู้ใช้จะปิดเอง
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    var tmr:NSTimer = NSTimer()
    func tmTickTock() {
        
        self.tmDisplay = self.tmDisplay + 1
        
    }
    
    func tmStop() {
        
        self.tmr.invalidate()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        tmStop()
    }
    
    func sayHello() {
        
        if(self.viewAlert.alpha < 1){
            
            if(((self.lastClosedSet == self.bannerSet && self.tmDisplay > self.timerForOpenAgain)) || (self.lastClosedSet != self.bannerSet)){
                
                viewBanner.reloadDataWithCompleteBlock({a in
                    
                    self.tmr.invalidate()
                    self.tmDisplay = 0
                    self.lastClosedSet = self.bannerSet
                    
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    
                    self.viewBanner.setCurrentPage(0, animated: false)
                    
                    UIView.animateWithDuration(0.2, animations: {
                        
                        self.viewAlertBg.hidden = false
                        self.viewAlertBg.alpha = 0.9
                        
                        self.viewAlert.hidden = false
                        self.viewAlert.alpha = 1
                        
                        
                        //print("sayHello xxxx!")
                        
                        }, completion:{_action in
                            
                            self.pulsator.stop()
                            //print("sayHello zzzzzz!")
                            
                    })
                    
                })
                
            }else{
                
                print("++++++++ รอเวลาเปิด +++++++++")
                
            }
            
        }else{
            
            if(self.lastClosedSet != self.bannerSet){
                self.closeBanner(true)
            }
            
        }
        
    }
    
    func closeBanner(andOpenDelay:Bool = false) {
        
        tmr = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.tmTickTock), userInfo: nil, repeats: true)
        pulsator.start()
        UIView.animateWithDuration(0.5, animations: {
            
            self.viewAlertBg.hidden = false
            self.viewAlertBg.alpha = 0
            
            self.viewAlert.hidden = false
            self.viewAlert.alpha = 0
            
            }, completion:{_action in
                
                self.viewAlert.hidden = true
                self.viewAlertBg.hidden = true
                
                if(andOpenDelay){
                    NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.sayHello), userInfo: nil, repeats: false)
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
//        viewAlert.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(self.view)
//            make.center.equalTo(self.view)
//            //make.center.equalTo(self.frmView.size).offset(CGPointMake(0, -100))
//        }
        viewAlert.frame = frmView
        viewAlert.center.x = frmView.size.width / 2
        viewAlert.center.y = frmView.size.height / 2
        
//        viewAlertBg.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(viewAlert)
//            make.center.equalTo(viewAlert)
//        }
        viewAlertBg.frame = frmView
        viewAlertBg.center.x = frmView.size.width / 2
        viewAlertBg.center.y = frmView.size.height / 2
        
        
        
//        btnCloseBanner.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(40,40))
//            make.top.equalTo(30)
//            make.right.equalTo(btnCloseBanner.frame.size.width - 10)
//            //make.right.equalTo(viewAlert).offset(-50)
//            //make.center.equalTo(self.frmView.size).offset(CGPointMake(0, -100))
//        }
        btnCloseBanner.frame.size = CGSizeMake(40, 40)
        btnCloseBanner.frame.origin.x = btnCloseBanner.frame.size.width - 10
        btnCloseBanner.frame.origin.y = 30
        //-- -- -- -- -- -- -- -- -- -- --
        
        //viewBanner = KDCycleBannerView()
        viewBanner.frame = frmView;
        viewBanner.datasource = self;
        viewBanner.delegate = self;
        viewBanner.continuous = true;
        viewBanner.autoPlayTimeInterval = 8;
        
        
        let alertBannerWidth = frmView.size.width - 20
        let alertBannerHeight = frmView.size.height - 20
//        viewBanner.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(alertBannerWidth, alertBannerHeight))
//            make.center.equalTo(viewAlert)
//        }
        viewBanner.frame.size = CGSizeMake(alertBannerWidth, alertBannerHeight)
        viewBanner.center.x = viewAlert.frame.size.width / 2
        viewBanner.center.y = viewAlert.frame.size.height / 2
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
    
//    //----------  View Loading...  -----------
//    lazy var viewLoading1 = UIView()
//    lazy var viewLoading2 = UIView()
//    lazy var viewLoading3 = UIView()
//    lazy var viewLoading4 = UIView()
//    //----------------------------------------
    
    let pulsator = Pulsator()
    let kMaxRadius: CGFloat = 200
    let kMaxDuration: NSTimeInterval = 10
    
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
        
        //lblBottom.backgroundColor = UIColor.blueColor()
        //lblBottom.alpha = 0.5
        lblBottom.text = "Use your phone to locate any iBeacons around you"
        lblBottom.textAlignment = .Center
        lblBottom.font.fontWithSize(14)
        lblBottom.adjustsFontSizeToFitWidth = true
        lblBottom.minimumScaleFactor = 0.2
        
        setViewIsLoading()
        
        self.viewMainbackground.addSubview(imgBackground)
        self.viewTitleBox.addSubview(imgCircle)
        self.viewTitleBox.addSubview(imgTitleText)
        self.viewDescriptionBox.addSubview(imgDescriptionText)
        
        self.view.addSubview(viewMainbackground)
        self.view.addSubview(viewTitleBox)
        self.view.addSubview(viewDescriptionBox)
        self.view.addSubview(lblBottom)
        
        //self.viewTitleBox.backgroundColor = UIColor.blueColor()
//        self.viewTitleBox.addSubview(viewLoading1)
//        self.viewTitleBox.addSubview(viewLoading2)
//        self.viewTitleBox.addSubview(viewLoading3)
//        self.viewTitleBox.addSubview(viewLoading4)
        
        
        //-- -- -- -- -- -- -- -- -- -- --
//        viewMainbackground.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(0)
//            make.left.equalTo(0)
//            make.bottom.equalTo(0)
//            make.right.equalTo(0)
//        }
        viewMainbackground.frame = self.view.frame
        viewMainbackground.frame.origin.x = 0
        viewMainbackground.frame.origin.y = 0
        
        
        let titleBoxSize = frmView.size.width - 60
//        viewTitleBox.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(60)
//            make.size.equalTo(CGSizeMake(titleBoxSize, titleBoxSize))
//            make.centerX.equalTo(viewMainbackground)
//        }
        viewTitleBox.frame.size = CGSizeMake(titleBoxSize, titleBoxSize)
        viewTitleBox.center.x = viewMainbackground.frame.size.width / 2
        viewTitleBox.frame.origin.y = 60
        
        
        
        let DesBoxSize = frmView.size.width - 120
//        viewDescriptionBox.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(DesBoxSize, DesBoxSize))
//            make.top.equalTo(viewTitleBox).offset(titleBoxSize - 120)
//            make.centerX.equalTo(viewMainbackground)
//        }
        viewDescriptionBox.frame.size = CGSizeMake(DesBoxSize, DesBoxSize)
        viewDescriptionBox.center.x = viewMainbackground.frame.size.width / 2
        viewDescriptionBox.center.y = viewTitleBox.frame.size.height - titleBoxSize - 120
        
        
        
        
        //------
//        imgBackground.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(0)
//            make.left.equalTo(0)
//            make.bottom.equalTo(0)
//            make.right.equalTo(0)
//        }
        imgBackground.frame.size = self.viewMainbackground.frame.size
        imgBackground.center.x = 0
        imgBackground.center.y = 0
        
        
        
        let imgTitleBoxSize = frmView.size.width - 80
//        imgCircle.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(imgTitleBoxSize, imgTitleBoxSize))
//            make.center.equalTo(viewTitleBox)
//        }
        imgCircle.frame.size = CGSizeMake(imgTitleBoxSize, imgTitleBoxSize)
        imgCircle.center.x = viewTitleBox.frame.size.width / 2
        imgCircle.center.y = viewTitleBox.frame.size.height / 2
        
        
        
        let imgTitleTextSize = frmView.size.width - 50
//        imgTitleText.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(imgTitleTextSize, imgTitleTextSize))
//            make.center.equalTo(viewTitleBox)
//        }
        imgTitleText.frame.size = CGSizeMake(imgTitleTextSize, imgTitleTextSize)
        imgTitleText.center.x = viewTitleBox.frame.size.width / 2
        imgTitleText.center.y = viewTitleBox.frame.size.height / 2
        
        
        
        
//        imgDescriptionText.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(DesBoxSize, DesBoxSize))
//            make.center.equalTo(viewDescriptionBox)
//        }
        imgDescriptionText.frame.size = CGSizeMake(DesBoxSize, DesBoxSize)
        imgDescriptionText.center.x = viewDescriptionBox.frame.size.width / 2
        imgDescriptionText.center.y = viewDescriptionBox.frame.size.height / 2
        
        
        
        
//        lblBottom.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(self.view.frame.size.width - 20, 40))
//            make.centerX.equalTo(self.view)
//            make.bottom.equalTo(0)
//        }
        lblBottom.frame.size = CGSizeMake(self.view.frame.size.width - 20, 40)
        lblBottom.center.x = self.view.frame.size.width / 2
        lblBottom.frame.origin.y = self.view.frame.size.height - lblBottom.frame.size.height
        
        // ===== Loading... =====
        
        
        
        //self.imgCircle.alpha = 0
        
        //self.viewLoading1 = self.setViewLoadingStart(self.viewLoading1)
        
//        let sizeViewLoadingStart = viewTitleBox.frame.size.width - 140
//        let frmLoadingStart = CGRectMake(70, 70, sizeViewLoadingStart, sizeViewLoadingStart)
//        
//        viewLoading1.frame = frmLoadingStart
//        
//        //self.viewLoading1.backgroundColor = UIColor.greenColor()
//        self.viewLoading1.layer.cornerRadius = self.viewLoading1.frame.size.width / 2
//        self.viewLoading1.layer.borderColor = UIColor.whiteColor().CGColor
//        self.viewLoading1.layer.borderWidth = 5
//        
//        self.viewLoading2.layer.borderColor = UIColor.whiteColor().CGColor
//        self.viewLoading2.layer.borderWidth = 5
//        
//        self.viewLoading3.layer.borderColor = UIColor.whiteColor().CGColor
//        self.viewLoading4.layer.borderWidth = 5
//        
//        self.viewLoading4.layer.borderColor = UIColor.whiteColor().CGColor
//        self.viewLoading4.layer.borderWidth = 5
        
//        let sizeViewLoading = self.viewTitleBox.frame.size.width
        //        pulsator.translatesAutoresizingMaskIntoConstraints = true
        //pulsator.frame = CGRectMake(0, 0, sizeViewLoading, sizeViewLoading)
        
        
        
        //setViewIsLoading()
    }
    
    
    
//    func setViewLoadingStart(view:UIView) -> UIView {
//        
//        let sizeViewLoadingStart = self.viewTitleBox.frame.size.width - 140
////        let frmLoadingStart = CGRectMake(70, 70, sizeViewLoadingStart, sizeViewLoadingStart)
////        
////        view.frame = frmLoadingStart
//        
//        //self.viewLoading1.backgroundColor = UIColor.greenColor()
//        view.layer.cornerRadius = view.frame.size.width / 2
//        view.layer.borderColor = UIColor.whiteColor().CGColor
//        view.layer.borderWidth = 5
//        
//        view.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(sizeViewLoadingStart, sizeViewLoadingStart))
//            make.center.equalTo(viewTitleBox)
//        }
//        
//        return view
//    }
//    
    func setViewIsLoading() {
        
        let viewForpulsator = UIView()
        viewTitleBox.addSubview(viewForpulsator)
//        viewForpulsator.snp_makeConstraints { (make) -> Void in
//            make.size.equalTo(CGSizeMake(1, 1))
//            make.center.equalTo(viewTitleBox)
//        }
        viewTitleBox.backgroundColor = UIColor.greenColor()
        viewTitleBox.alpha = 0.7
        viewForpulsator.frame.size = CGSizeMake(1, 1)
        viewForpulsator.frame.origin.x = viewTitleBox.frame.size.width / 2
        viewForpulsator.frame.origin.y = viewTitleBox.frame.size.height / 2
        viewForpulsator.backgroundColor = UIColor.redColor()
        
        
        viewForpulsator.layer.addSublayer(pulsator)
        
        
        //pulsator.backgroundColor = UIColor.whiteColor().CGColor
        pulsator.backgroundColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1.0).CGColor
        pulsator.radius = 160
        pulsator.animationDuration = 6
        pulsator.numPulse = 6
        pulsator.contentsCenter = self.viewTitleBox.frame
        pulsator.start()
        
    }
    
    
}

