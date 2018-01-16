//
//  FirstViewController.swift
//  P9_APIVoyage
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // View change rate
        let tabOne = ChangeRateController()
        let tabOneBarItem = UITabBarItem(title: "Change", image: #imageLiteral(resourceName: "first"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
        
        // View translate view
        let tabTwo = TranslatationController()
        let tabTwoBarItem2 = UITabBarItem(title: "Translate", image: #imageLiteral(resourceName: "second"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwo.tabBarItem = tabTwoBarItem2
        
        // View meteo
        let tabTree = MeteoController()
        let tabTwoBarItem3 = UITabBarItem(title: "Meteo", image: #imageLiteral(resourceName: "first"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTree.tabBarItem = tabTwoBarItem3
        
        self.viewControllers = [tabOne, tabTwo, tabTree]
    }
}

