//
//  ViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//

import CoreData
import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    
    private func fetchData() {
        
        APIManager.shared.getPersonnelLosses(viewContext: PersistenceController.shared.container.viewContext) { error in
            if let error = error {
                // Handle the error here
                print("Error fetching and saving personnel losses:", error)
            } else {
                // Successfully fetched and saved personnel losses
                print("Personnel losses fetched and saved successfully.")
            }
        }
        
    }
    
}



