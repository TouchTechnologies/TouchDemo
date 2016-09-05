//
//  CouponVC.swift
//  TouchDemo
//
//  Created by Thirawat Phannet on 1/9/59.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import FontAwesome_swift

class CouponVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.tabBar.barTintColor = UIColor.redColor()
//        tabItem.image = UIImage.fontAwesomeIconWithName(.Ticket, textColor: UIColor.blackColor(), size: CGSizeMake(50, 50))
        
//        let testView = UIView(frame: CGRectMake(20, 50, 200, 30))
////        testView.backgroundColor = UIColor
//        testView.backgroundColor = SWColor(hexString: "#ccaaaa")
//        self.view.addSubview(testView)
        
        loadWebview()
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        //let url = NSURL(string: "http://192.168.1.117/seeitlivethailand/coupon")

        let req = NSMutableURLRequest(URL: NSURL(string: "http://www.seeitlivethailand.com/coupon")!)
        //request.HTTPMethod = "GET"
        req.addValue("jr0yvLLVjzY4VGk6KjoOm5c6BK5lGSw52p1QDra4", forHTTPHeaderField: "x-tit-access-token")
        req.addValue("iOS", forHTTPHeaderField: "x-tit-web-view")
        
        self.webview.loadRequest(req)
        
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
    
}

