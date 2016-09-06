//
//  LaunchScreenVC.swift
//  TouchDemo
//
//  Created by weerapons suwanchatree on 8/2/2559 BE.
//  Copyright © 2559 weerapons suwanchatree. All rights reserved.
//

import UIKit

class IntroVC: UIViewController{
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.image = UIImage(named: Env.iPad ? "bg_ipad" : "bg")
        image.contentMode = .ScaleAspectFill
        
    }
    
}



