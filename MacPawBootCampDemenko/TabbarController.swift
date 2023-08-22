//
//  TabbarController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.setupTabs()
    }
    
    
    private func setupTabs(){
        let personalLosses = self.createNav(with: "Personal Losses",
                                            and: UIImage(systemName: "person.2"),
                                            vc: ViewController())
        let equipmentLosses = self.createNav(with: "Equipment Losses",
                                             and: UIImage(systemName: "hand.raised.square.on.square"),
                                             vc: EquipmentLosses())
        let donation = self.createNav(with: "Donation",
                                      and: UIImage(systemName: "dollarsign.circle"),
                                      vc: DonationViewController())
        self.setViewControllers([personalLosses, equipmentLosses,donation], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        nav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
      
        
        return nav
    }
}
