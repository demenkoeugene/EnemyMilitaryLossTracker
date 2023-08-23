//
//  EquipmentLosses.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit
import CoreData

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData {
            // This block will be executed after data fetching and sorting are done
            // You can place the code that depends on the fetched data here
            let currentDate = self.results.first?.date ?? Date() // Get the current date
            print("current date \(currentDate)")
            self.fetchMilitaryLosses(for: currentDate) // Fetch data for the current date
            self.datePicker.date = currentDate
        }
        
        createDataPicker()
        // Add dataLabel to the view hierarchy
        view.addSubview(dataLabel)
        
        // Configure Auto Layout constraints for the label
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
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
            let formattedLossData = """
            Day: \(militaryLoss.day)
            Aircraft: \(militaryLoss.aircraft)
            Helicopter: \(militaryLoss.helicopter)
            Tank: \(militaryLoss.tank)
            APC: \(militaryLoss.apc)
            Field Artillery: \(militaryLoss.fieldArtillery)
            MRL: \(militaryLoss.mrl)
            Military Auto: \(militaryLoss.militaryAuto)
            Fuel Tank: \(militaryLoss.fuelTank)
            Drone: \(militaryLoss.drone)
            Naval Ship: \(militaryLoss.navalShip)
            Anti-Aircraft Warfare: \(militaryLoss.antiAircraftWarfare)
            """
            dataLabel.text = formattedLossData
            dataLabel.layoutIfNeeded() // Force layout update
        } else {
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




