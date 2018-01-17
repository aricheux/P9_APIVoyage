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
        tabOne.tabBarItem = UITabBarItem(title: "Change", image: #imageLiteral(resourceName: "dollar"), selectedImage: nil)
        
        // View translate view
        let tabTwo = TranslatationController()
        tabTwo.tabBarItem = UITabBarItem(title: "Translate", image: #imageLiteral(resourceName: "translate"), selectedImage: nil)
        
        // View meteo
        let tabTree = MeteoController()
        tabTree.tabBarItem = UITabBarItem(title: "Meteo", image: #imageLiteral(resourceName: "soleil-1"), selectedImage: nil)
        
        self.viewControllers = [tabOne, tabTwo, tabTree]
    }
}

