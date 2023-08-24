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
        let equipmentLosses = self.createNav(with: "Losses",
                                             imageName: "imgPersLose",
                                             vc: LossesController())
        
        let personalLosses = self.createNav(with: "Equipment Losses",
                                            imageName: "rocket",
                                            vc: EquipmentController())
        let donation = self.createNav(with: "Donation",
                                      imageName: "UkraineTrident",
                                      vc: DonationViewController())
        self.setViewControllers([equipmentLosses, personalLosses,donation], animated: true)
    }
    
    private func createNav(with title: String, imageName: String, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        if let originalImage = UIImage(named: imageName) {
            let resizedImage = originalImage.resize(to: CGSize(width: 30, height: 30))
            nav.tabBarItem.image = resizedImage
        }
        
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.prefersLargeTitles = true
        nav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
        
        // Add a fixed space bar button item to create space between tab bar items
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 20 // Adjust the value to control the spacing
        
        
        return nav
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
