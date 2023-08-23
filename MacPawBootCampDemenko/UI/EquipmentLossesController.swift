//
//  EquipmentLosses.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit
import CoreData

struct Labels {
    let dayLabel = UILabel()
    let aircraftLabel = UILabel()
    let helicopterLabel = UILabel()
    let tankLabel = UILabel()
    let APCLabel = UILabel()
    let fieldArtilleryLabel = UILabel()
    let MRLLabel = UILabel()
    let militaryAutoLabel = UILabel()
    let fuelTankLabel = UILabel()
    let droneLabel = UILabel()
    let navalShipLabel = UILabel()
    let antiAircraftWarfareLabel = UILabel()
}

class EquipmentLossesController: UIViewController {
    
    let context = PersistenceController.shared.container.viewContext
    var results: [MilitaryLosses] = []
    let datePicker = UIDatePicker()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0 // Allow multiple lines if needed
        return label
    }()
    
    var labels = Labels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData {
            // This block will be executed after data fetching and sorting are done
            let currentDate = self.results.first?.date ?? Date() // Get the current date
            print("current date \(currentDate)")
            self.fetchMilitaryLosses(for: currentDate) // Fetch data for the current date
            self.datePicker.date = currentDate
        }
        
        createDataPicker()
        // Add dataLabel to the view hierarchy
        view.addSubview(dataLabel)
        setupLabelConstraints()
        
        // Configure Auto Layout constraints for the label
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    private func setupLabelConstraints() {
        let labelArray = [
            labels.dayLabel,
            labels.aircraftLabel,
            labels.helicopterLabel,
            labels.tankLabel,
            labels.APCLabel,
            labels.fieldArtilleryLabel,
            labels.MRLLabel,
            labels.militaryAutoLabel,
            labels.fuelTankLabel,
            labels.droneLabel,
            labels.navalShipLabel,
            labels.antiAircraftWarfareLabel
        ]
        
        for (index, label) in labelArray.enumerated() {
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
            // Configure Auto Layout constraints for the label
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            if index == 0 {
                // Position the first label below the data picker
                label.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 16).isActive = true
            } else {
                // Position subsequent labels below the previous label
                let previousLabel = labelArray[index - 1]
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 16).isActive = true
            }
        }
    }
    
    
    func createDataPicker() {
        // Create and configure the date picker
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the minimum date for the date picker
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let minDate = dateFormatter.date(from: "2022-02-24") {
            datePicker.minimumDate = minDate
        }
        
        // Set the maximum date for the date picker to the current date
        datePicker.maximumDate = Date()
        
        // Add the date picker to the view
        view.addSubview(datePicker)
        
        
        // Add Auto Layout constraints for positioning
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        print("Selected date:", selectedDate)
        
        fetchMilitaryLosses(for: selectedDate)
    }
    
    
    private func fetchMilitaryLosses(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Find the military loss entry that matches the selected date
        if let militaryLoss = results.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            labels.dayLabel.text = "Day: \(militaryLoss.day)"
            labels.aircraftLabel.text = "Aircraft: \(militaryLoss.aircraft)"
            labels.helicopterLabel.text = "Helicopter: \(militaryLoss.helicopter)"
            labels.tankLabel.text = "Tank: \(militaryLoss.tank)"
            labels.APCLabel.text = "APC: \(militaryLoss.apc)"
            labels.fieldArtilleryLabel.text = "Field Artillery: \(militaryLoss.fieldArtillery)"
            labels.MRLLabel.text = "MRL: \(militaryLoss.mrl)"
            labels.militaryAutoLabel.text = "Military Auto: \(militaryLoss.militaryAuto)"
            labels.fuelTankLabel.text = "Fuel Tank: \(militaryLoss.fuelTank)"
            labels.droneLabel.text = "Drone: \(militaryLoss.drone)"
            labels.navalShipLabel.text = "Naval Ship: \(militaryLoss.navalShip)"
            labels.antiAircraftWarfareLabel.text = "Anti-Aircraft Warfare: \(militaryLoss.antiAircraftWarfare)"
            dataLabel.text = ""
        } else {
            // Clear the text of all labels
            labels.dayLabel.text = ""
            labels.aircraftLabel.text = ""
            labels.helicopterLabel.text = ""
            labels.tankLabel.text = ""
            labels.APCLabel.text = ""
            labels.fieldArtilleryLabel.text = ""
            labels.MRLLabel.text = ""
            labels.militaryAutoLabel.text = ""
            labels.fuelTankLabel.text = ""
            labels.droneLabel.text = ""
            labels.navalShipLabel.text = ""
            labels.antiAircraftWarfareLabel.text = ""
            
            
            dataLabel.text = "No data available for the selected date."
        }
    }
    
}

extension EquipmentLossesController {
    
    private func fetchData(completion: @escaping () -> Void) {
        APIManager.shared.getEquipmentLosses(viewContext: context) { error in
            if let error = error {
                // Handle the error here
                print("Error fetching and saving personnel losses:", error)
            } else {
                // Data fetched and saved successfully
                print("Personnel losses fetched and saved successfully.")
            }
            
            let fetchRequest: NSFetchRequest<MilitaryLosses> = MilitaryLosses.fetchRequest()
            do {
                self.results = try self.context.fetch(fetchRequest)
                self.results.sort { $0.date > $1.date }
                completion() // Call the completion handler
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
    
}




