//
//  EquipmentLosses.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class EquipmentLossesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Create a segmented control
        let segmentedControl = UISegmentedControl(items: ["during the war", "data based on Oryx"])
        
        // Set initial selected segment (optional)
        segmentedControl.selectedSegmentIndex = 0
        
        // Add a target action for the value changed event
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        // Add the segmented control to the view
        view.addSubview(segmentedControl)
        
        // Add Auto Layout constraints for positioning
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Handle segmented control value change here
        switch sender.selectedSegmentIndex {
        case 0:
            // Handle option 1
            break
        case 1:
            // Handle option 2
            break
     
        default:
            break
        }
    }
}
