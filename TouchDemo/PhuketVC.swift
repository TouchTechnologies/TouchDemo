//
//  PhuketVC.swift
//  TouchDemo
//
//  Created by Thirawat Phannet on 1/9/59.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import FontAwesome_swift

class PhuketVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        loadWebview()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    var btnItemLeft = UIButton()
    var btnItemRight = UIButton()
    var itemRight = UIActivityIndicatorView()
    
    var btnItemBarLeft = UIBarButtonItem()
    var btnItemBarRight = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.tabBar.barTintColor = UIColor.blueColor()
//        tabItem.image = UIImage.fontAwesomeIconWithName(.Map, textColor: UIColor.blackColor(), size: CGSizeMake(50, 50))
//        
//        let testView = UIView(frame: CGRectMake(40, 80, 200, 30))
////        testView.backgroundColor = UIColor
//        testView.backgroundColor = SWColor(hexString: "#a33eea")
//        self.view.addSubview(testView)
        
        
        let imgLeft = UIImage.fontAwesomeIconWithName(.ChevronLeft, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        let imgRight = UIImage.fontAwesomeIconWithName(.Spinner, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        let imgLeftA = UIImage.fontAwesomeIconWithName(.ChevronLeft, textColor: UIColor.redColor(), size: CGSizeMake(30, 30))
        let imgRightA = UIImage.fontAwesomeIconWithName(.Spinner, textColor: UIColor.redColor(), size: CGSizeMake(30, 30))
        
        btnItemLeft.frame = CGRectMake(0, 0, 30, 30)
        //btnItemLeft.imageView?.image = imgLeft
        btnItemLeft.setBackgroundImage(imgLeft, forState: .Normal)
        btnItemLeft.setBackgroundImage(imgLeftA, forState: .Highlighted)
        btnItemLeft.addTarget(self, action: #selector(PhuketVC.btnLeftClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnItemBarLeft = UIBarButtonItem(customView: btnItemLeft)
        
        btnItemRight.frame = CGRectMake(0, 0, 30, 30)
        //btnItemRight.imageView?.image = imgRight
        btnItemRight.setBackgroundImage(imgRight, forState: .Normal)
        btnItemRight.setBackgroundImage(imgRightA, forState: .Highlighted)
        btnItemRight.addTarget(self, action: #selector(PhuketVC.btnRightClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        btnItemBarRight = UIBarButtonItem(customView: btnItemRight)
        
        btnItemLeft.hidden = true
        btnItemRight.hidden = true
        
        //navigationItem.leftBarButtonItem = btnItemBarLeft
        //navigationItem.rightBarButtonItem = btnItemBarRight
        
        
        
        
        
        //http://seeitlivethailand.com/promote_page/phuket
        
    }
    
    func btnLeftClick(sender: UIButton) {
        
        
        
        print("btnLeftClick")
        
    }
    
    func btnRightClick(sender: UIButton) {
        
        print("btnRightClick")
        
        
        
    }
    
    func loadWebview() {
        print("loadWebview")
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        //
        //            dispatch_async(dispatch_get_main_queue(), {
        //
        //            });
        //
        //        });
        
        let req = NSMutableURLRequest(URL: NSURL(string: "http://www.seeitlivethailand.com/promote_page/phuket")!)
        //request.HTTPMethod = "GET"
        req.addValue("jr0yvLLVjzY4VGk6KjoOm5c6BK5lGSw52p1QDra4", forHTTPHeaderField: "x-tit-access-token")
        req.addValue("iOS", forHTTPHeaderField: "x-tit-web-view")

        self.webview.loadRequest(req)
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("shouldStartLoadWithRequest")
        
        let headerIsPresentToken: Bool = request.allHTTPHeaderFields!["x-tit-access-token"] != nil
        let headerIsPresentWeb: Bool = request.allHTTPHeaderFields!["x-tit-web-view"] != nil
        if headerIsPresentToken && headerIsPresentWeb{
            print("headerIsPresentToken && headerIsPresentWeb")
            return true
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            dispatch_async(dispatch_get_main_queue(), {
                
                let req = NSMutableURLRequest(URL: request.URL!)
                req.addValue("jr0yvLLVjzY4VGk6KjoOm5c6BK5lGSw52p1QDra4", forHTTPHeaderField: "x-tit-access-token")
                req.addValue("iOS", forHTTPHeaderField: "x-tit-web-view")
                
                self.webview.loadRequest(req)
                
            });
            
        });
        
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
        
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        
        
    }
    
}

