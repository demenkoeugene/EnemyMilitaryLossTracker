//
//  DetailViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedEquipmentArray: [EquipmentLossesOryx]?
    
    // Labels to display the data
    let dayLabel = UILabel()
    let personnelLabel = UILabel()
    let powLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = selectedEquipmentArray?.first?.equipmentOryx
        
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        
        setupUI()
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // Helper function to set up the UI
    private func setupUI() {
      
    }
    

}

