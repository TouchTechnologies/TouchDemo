//
//  AppDelegate.swift
//  TouchDemo
//
//  Created by weerapons suwanchatree on 8/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    

    let heroIconManager = HeroIconManager()
    let beaconNotificationsManager = BeaconNotificationsManager()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ESTConfig.setupAppID("touchdemo-fen", andAppToken: "c6fda9bcf6dc54cfb4ae9c94aea9e8ca")
        
        self.heroIconManager.enableHeroIconForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE01", major: 4225, minor: 21861))//mint
        self.heroIconManager.enableHeroIconForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE02", major: 62648, minor: 16128))//ice
        self.heroIconManager.enableHeroIconForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE03", major: 20999, minor: 49007))//blueberry
        // NOTE: if you come in range of the beacon with the screen turned on, you'll need to turn it off and then on again for the app icon to show on the lock screen.
        
        self.beaconNotificationsManager.enableNotificationsForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE01", major: 4225, minor: 21861),//mint
            enterMessage: "Hi, Connect me",
            exitMessage:nil// "Goodbye, Mint."
        )
        self.beaconNotificationsManager.enableNotificationsForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE02", major: 62648, minor: 16128),//ice
            enterMessage: "Hi, Connect me",
            exitMessage:nil// "Goodbye, ice."
        )
        self.beaconNotificationsManager.enableNotificationsForBeaconID(
            BeaconID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE03", major: 20999, minor: 49007),//blueberry
            enterMessage: "Hi, Connect me",
            exitMessage:nil// "Goodbye, blueberry."
        )
        
        
        
        
        //UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
//        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(AppDelegate.setFakeValue), userInfo: nil, repeats: false)
//        
//        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(AppDelegate.setFakeValue2), userInfo: nil, repeats: false)
        
        // NOTE: "exit" event has a built-in delay of 30 seconds, to make sure that the user has really exited the beacon's range. The delay is imposed by iOS and is non-adjustable.
        
        return true
    }
    
    
//    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
//        
//        print("didEnterRegion")
//        print(manager)
//        print(region)
//        print("--------------")
//        
//    }
//    
//    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
//        
//        print("didExitRegion")
//        print(manager)
//        print(region)
//        print("--------------")
//        
//    }
  
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

