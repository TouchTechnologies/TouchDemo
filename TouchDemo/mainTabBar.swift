//
//  mainTabBar.swift
//  TouchDemo
//
//  Created by Thirawat Phannet on 1/9/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class mainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UITabBarController -> mainTabBar")
        
        //tabItem.image = UIImage.fontAwesomeIconWithName(.Home, textColor: UIColor.blackColor(), size: CGSizeMake(50, 50))
        
        self.tabBar.tintColor = UIColor.blackColor()
        self.tabBar.translucent = true
//        self.tabBar.barTintColor = UIColor.yellowColor() // สีพื้นหลัง
        
        
        if let tabIcons = self.tabBar.items! as Array? {
            
            print("tabIcons")
            print(tabIcons)
            
            for item in tabIcons{
                let itemBar:UITabBarItem = item
                
                let sizeTabIcon = CGSizeMake(30, 30)
                let colorTabIcon = UIColor.greenColor() // UIColor.grayColor()
                let colorTabIconActive = UIColor.blackColor()
                var imgIcon = UIImage()
                var imgIconActive = UIImage()
                
                if itemBar.tag == 1 {
                    imgIcon = UIImage.fontAwesomeIconWithName(.Home, textColor: colorTabIcon, size: sizeTabIcon)
                    imgIconActive = UIImage.fontAwesomeIconWithName(.Home, textColor: colorTabIconActive, size: sizeTabIcon)
                }else if itemBar.tag == 2 {
                    imgIcon = UIImage.fontAwesomeIconWithName(.Ticket, textColor: colorTabIcon, size: sizeTabIcon)
                    imgIconActive = UIImage.fontAwesomeIconWithName(.Ticket, textColor: colorTabIconActive, size: sizeTabIcon)
                }else if itemBar.tag == 3 {
                    imgIcon = UIImage.fontAwesomeIconWithName(.Map, textColor: colorTabIcon, size: sizeTabIcon)
                    imgIconActive = UIImage.fontAwesomeIconWithName(.Map, textColor: colorTabIconActive, size: sizeTabIcon)
                }
                
                itemBar.image = imgIcon
                itemBar.selectedImage = imgIconActive
                
                
            }
            
        }
        
        
    }
    
}
