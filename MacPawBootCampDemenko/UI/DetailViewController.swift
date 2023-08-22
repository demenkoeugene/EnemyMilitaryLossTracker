//
//  DetailViewController.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var selectedResult: PersonnelLosses?
    
    // Labels to display the data
    let dateLabel = UILabel()
    let dayLabel = UILabel()
    let personnelLabel = UILabel()
    let personnelInfoLabel = UILabel()
    let powLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = selectedResult?.date
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
        // Configure labels here, set their positions, fonts, etc.
        
        // Example configuration:
        dateLabel.frame = CGRect(x: 20, y: 100, width: 200, height: 30)
        dayLabel.frame = CGRect(x: 20, y: 140, width: 200, height: 30)
        personnelLabel.frame = CGRect(x: 20, y: 180, width: 200, height: 30)
        personnelInfoLabel.frame = CGRect(x: 20, y: 220, width: 200, height: 30)
        powLabel.frame = CGRect(x: 20, y: 260, width: 200, height: 30)
        
        // Add labels to the view
        view.addSubview(dateLabel)
        view.addSubview(dayLabel)
        view.addSubview(personnelLabel)
        view.addSubview(personnelInfoLabel)
        view.addSubview(powLabel)
        displaySelectedResultData()
    }
    
    private func displaySelectedResultData() {
        if let selectedResult = selectedResult {
            dateLabel.text = "Date: \(selectedResult.date)"
            dayLabel.text = "Day: \(selectedResult.day)"
            personnelLabel.text = "Personnel: \(selectedResult.personnel)"
            personnelInfoLabel.text = "Personnel Info: \(selectedResult.personnelInfo)"
            
            let optionalPow: Int? = Int(selectedResult.pow) // Convert Int32 to optional Int
                 
                 if let pow = optionalPow {
                     powLabel.text = "POW: \(pow)"
                 } else {
                     powLabel.text = "POW: Not tracked since 2022-04-28"
                 }
        }
    }
}

