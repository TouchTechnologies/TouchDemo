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
        longPress.minimumPressDuration = 5
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
                UIImage(named: "ib_r_p1")!
            ]
        }else if (bannerSet == 2){
            return [
                UIImage(named: "ib_L_p2")!,
                UIImage(named: "ib_r_p2")!
//                UIImage(named: "ib_r_p2")!
            ]
        }else if (bannerSet == 3){
            return [
                UIImage(named: "smart_p1")!,
                UIImage(named: "smart_p2")!,
                UIImage(named: "smart_p3")!
            ]
        }else{
            return [
//                UIImage(named: "ib_L_p1")!,
                UIImage(named: "ib_L_p2")!,
                UIImage(named: "ib_r_p2")!
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
        btnCloseBanner.setImage(UIImage(named: "btn_close"), forState: .Normal)
        
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
        btnCloseBanner.clipsToBounds = true
        btnCloseBanner.layer.cornerRadius = 20
        btnCloseBanner.backgroundColor = UIColor.whiteColor()
        //btnCloseBanner.alpha = 0.6
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
        
        imgBackground.image = UIImage(named: Env.iPad ? "bg_ipad" : "bg")
        imgBackground.contentMode = .ScaleAspectFill
        //imgBackground.contentMode = .Bottom
        
        imgCircle.image = UIImage(named: "circle")
        imgCircle.contentMode = .ScaleAspectFit
        //imgCircle.backgroundColor = UIColor.redColor()
        
        imgTitleText.image = UIImage(named: "logo")
        imgTitleText.contentMode = .ScaleAspectFit
        //imgTitleText.backgroundColor = UIColor.greenColor()
        
        imgDescriptionText.image = UIImage(named: "smart_logo")
        imgDescriptionText.contentMode = .ScaleAspectFit
        
        lblBottom.textColor = UIColor.grayColor()
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
        
        //        //self.viewTitleBox.backgroundColor = UIColor.blueColor()
        //        self.viewTitleBox.addSubview(viewLoading1)
        //        self.viewTitleBox.addSubview(viewLoading2)
        //        self.viewTitleBox.addSubview(viewLoading3)
        //        self.viewTitleBox.addSubview(viewLoading4)
        
        //-- -- -- -- -- -- -- -- -- -- --
        
        viewMainbackground.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        
        
        let titleBoxSize = frmView.size.width - 60
        let titleBoxSizeIpad = frmView.size.width - 240
        viewTitleBox.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(Env.iPad ? 40 : 60)
            make.size.equalTo(Env.iPad ? CGSizeMake(titleBoxSizeIpad, titleBoxSizeIpad) : CGSizeMake(titleBoxSize, titleBoxSize))
            make.centerX.equalTo(viewMainbackground)
        }
        //        viewTitleBox.backgroundColor = UIColor.blueColor()
        //        viewTitleBox.alpha = 0.6
        
        let DesBoxSize = frmView.size.width - 120
        let DesBoxSizeIpad = frmView.size.width - 380
        viewDescriptionBox.snp_makeConstraints { (make) -> Void in
            //make.size.equalTo(CGSizeMake(DesBoxSize, DesBoxSize))
            make.size.equalTo(Env.iPad ? CGSizeMake(DesBoxSizeIpad, DesBoxSizeIpad) : CGSizeMake(DesBoxSize, DesBoxSize))
            make.top.equalTo(viewTitleBox).offset(Env.iPad ? titleBoxSize - 420 : titleBoxSize - 120)
            make.centerX.equalTo(viewMainbackground)
        }
        //        viewDescriptionBox.backgroundColor = UIColor.greenColor()
        //        viewDescriptionBox.alpha = 0.6
        
        //------
        imgBackground.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        let imgTitleBoxSize = frmView.size.width - 80
        let imgTitleBoxSizeIpad = frmView.size.width - 290
        imgCircle.snp_makeConstraints { (make) -> Void in
            //make.size.equalTo(CGSizeMake(imgTitleBoxSize, imgTitleBoxSize))
            make.size.equalTo(Env.iPad ? CGSizeMake(imgTitleBoxSizeIpad, imgTitleBoxSizeIpad) : CGSizeMake(imgTitleBoxSize, imgTitleBoxSize))
            make.center.equalTo(viewTitleBox)
        }
        
        let imgTitleTextSize = frmView.size.width - 50
        let imgTitleTextSizeIpad = frmView.size.width - 260
        imgTitleText.snp_makeConstraints { (make) -> Void in
            //make.size.equalTo(CGSizeMake(imgTitleTextSize, imgTitleTextSize))
            make.size.equalTo(Env.iPad ? CGSizeMake(imgTitleTextSizeIpad, imgTitleTextSizeIpad) : CGSizeMake(imgTitleTextSize, imgTitleTextSize))
            make.center.equalTo(viewTitleBox)
        }
        
        imgDescriptionText.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(Env.iPad ? CGSizeMake(DesBoxSizeIpad, DesBoxSizeIpad) : CGSizeMake(DesBoxSize, DesBoxSize))
            make.center.equalTo(viewDescriptionBox)
        }
        
        lblBottom.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(self.view.frame.size.width - 20, 40))
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(0)
        }
        
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
        viewForpulsator.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(1, 1))
            make.center.equalTo(viewTitleBox)
        }
        
        
        viewForpulsator.layer.addSublayer(pulsator)
        
        
        pulsator.backgroundColor = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1.0).CGColor
        //pulsator.backgroundColor = UIColor.whiteColor().CGColor
        pulsator.radius = Env.iPad ? 280 : 160
        pulsator.animationDuration = 6
        pulsator.numPulse = 6
        pulsator.contentsCenter = self.viewTitleBox.frame
        //pulsator.start()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.startPulsator), userInfo: nil, repeats: false)
        
    }
    
    func startPulsator() {
        
        
        pulsator.start()
    }
    
    
}

