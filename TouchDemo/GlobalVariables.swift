//
//  objActiveStatus.swift
//  TouchDemo
//
//  Created by Thirawat Phannet on 3/8/59.
//  Copyright © พ.ศ. 2559 weerapons suwanchatree. All rights reserved.
//


//var bannerIsShow: Bool
//var bannerSet: Int

import UIKit

class GlobalVariables {
    
    internal var myName: String = "Tak"
    internal var bannerIsShow: Bool = false
    internal var bannerSet: Int = 0
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
