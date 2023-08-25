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
    let personellLabel = UILabel()
    let aircraftLabel = UILabel()
    let helicopterLabel = UILabel()
    let tankLabel = UILabel()
    let APCLabel = UILabel()
    let fieldArtilleryLabel = UILabel()
    let MRLLabel = UILabel()
    let droneLabel = UILabel()
    let navalShipLabel = UILabel()
    let antiAircraftWarfareLabel = UILabel()
    let militaryAutoLabel = UILabel()
    let fuelTankLabel = UILabel()
}

class LossesController: UIViewController {
    
    let context = PersistenceController.shared.container.viewContext
    var results: [MilitaryLossesCoreData] = []
    var personnelArray: [PersonelLossesCoreData] = []
    var groupedData: [Date: (MilitaryLossesCoreData, PersonelLossesCoreData)] = [:]
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
            labels.personellLabel,
            labels.aircraftLabel,
            labels.helicopterLabel,
            labels.tankLabel,
            labels.APCLabel,
            labels.fieldArtilleryLabel,
            labels.MRLLabel,
            labels.droneLabel,
            labels.navalShipLabel,
            labels.antiAircraftWarfareLabel,
            labels.militaryAutoLabel,
            labels.fuelTankLabel
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
        if let (currentMilitaryLoss, currentPersonnelLoss) = groupedData[date],
           let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date),
           let (previousMilitaryLoss, previousPersonnelLoss) = groupedData[previousDate] {
            // Calculate the change in values
            let personellChange = currentPersonnelLoss.personnel - previousPersonnelLoss.personnel
            let aircraftChange = currentMilitaryLoss.aircraft - previousMilitaryLoss.aircraft
            let helicopterChange = currentMilitaryLoss.helicopter - previousMilitaryLoss.helicopter
            let tankChange = currentMilitaryLoss.tank - previousMilitaryLoss.tank
            let APCChange = currentMilitaryLoss.apc - previousMilitaryLoss.apc
            let fieldArtilleryChange = currentMilitaryLoss.fieldArtillery - previousMilitaryLoss.fieldArtillery
            let MRLChange = currentMilitaryLoss.mrl - previousMilitaryLoss.mrl
            let militaryAutoChange = currentMilitaryLoss.militaryAuto - previousMilitaryLoss.militaryAuto
            let fuelTankChange = currentMilitaryLoss.fuelTank - previousMilitaryLoss.fuelTank
            let droneChange = currentMilitaryLoss.drone - previousMilitaryLoss.drone
            let navalShipChange = currentMilitaryLoss.navalShip - previousMilitaryLoss.navalShip
            let antiAircraftWarfareShipChange = currentMilitaryLoss.antiAircraftWarfare - previousMilitaryLoss.antiAircraftWarfare
            
            // Display current day's values along with changes
            labels.dayLabel.text = "Day: \(currentMilitaryLoss.day)"
            labels.personellLabel.text = "Personell: \(currentPersonnelLoss.personnel) \(personellChange != 0 ? "(\(personellChange > 0 ? "+" : "")\(personellChange))" : "")"
            labels.aircraftLabel.text = "Personell: \(currentMilitaryLoss.aircraft) \(aircraftChange != 0 ? "(\(aircraftChange > 0 ? "+" : "")\(aircraftChange))" : "")"
           
            labels.helicopterLabel.text = "Helicopter: \(currentMilitaryLoss.helicopter) \(helicopterChange != 0 ? "(\(helicopterChange > 0 ? "+" : "")\(helicopterChange))" : "")"
            
            labels.tankLabel.text = "Tank: \(currentMilitaryLoss.tank) \(tankChange != 0 ? "(\(tankChange > 0 ? "+" : "")\(tankChange))" : "")"
            
            labels.APCLabel.text  = "APC: \(currentMilitaryLoss.apc) \(APCChange != 0 ? "(\(APCChange > 0 ? "+" : "")\(APCChange))" : "")"
            
            labels.fieldArtilleryLabel.text = "Field Artillery: \(currentMilitaryLoss.fieldArtillery) \(fieldArtilleryChange != 0 ? "(\(fieldArtilleryChange > 0 ? "+" : "")\(fieldArtilleryChange))" : "")"
            
            labels.MRLLabel.text = "MRL: \(currentMilitaryLoss.mrl) \(MRLChange != 0 ? "(\(MRLChange > 0 ? "+" : "")\(MRLChange))" : "")"
            
            labels.militaryAutoLabel.text = militaryAutoChange != 0
                ? "Military Auto: \(currentMilitaryLoss.militaryAuto) \(militaryAutoChange > 0 ? "+\(militaryAutoChange)" : "\(militaryAutoChange)")"
                : ""

            labels.fuelTankLabel.text = fuelTankChange != 0
                ? "Fuel Tank: \(currentMilitaryLoss.fuelTank) \(fuelTankChange > 0 ? "+\(fuelTankChange)" : "\(fuelTankChange)")"
                : ""

            
            labels.droneLabel.text = "Drone: \(currentMilitaryLoss.drone) \(droneChange != 0 ? "(\(droneChange > 0 ? "+" : "")\(droneChange))" : "")"
            
            labels.navalShipLabel.text = "Naval Ship: \(currentMilitaryLoss.navalShip)  \(navalShipChange != 0 ? "(\(navalShipChange > 0 ? "+" : "")\(navalShipChange))" : "")"
            
            labels.antiAircraftWarfareLabel.text = "Anti-Aircraft Warfare: \(currentMilitaryLoss.antiAircraftWarfare)  \(antiAircraftWarfareShipChange != 0 ? "(\(antiAircraftWarfareShipChange > 0 ? "+" : "")\(antiAircraftWarfareShipChange))" : "")"
            
            dataLabel.text = ""
        } else {
            // Clear the text of all labels
            labels.dayLabel.text = ""
            labels.personellLabel.text = ""
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



extension LossesController {
    
    private func fetchData(completion: @escaping () -> Void) {
        APIManager.shared.getEquipmentLosses(viewContext: context) { error in
            if let error = error {
                // Handle the error here
                print("Error fetching and saving equipment losses:", error)
            } else {
                APIManager.shared.getPersonnelLosses(viewContext: self.context) { [self] error in
                    if let error = error {
                        // Handle the error here
                        print("Error fetching and saving personnel losses:", error)
                    } else {
                        let fetchRequestMil: NSFetchRequest<MilitaryLossesCoreData> = MilitaryLossesCoreData.fetchRequest()
                        let fetchRequestPers: NSFetchRequest<PersonelLossesCoreData> = PersonelLossesCoreData.fetchRequest()
                        do {
                            self.results = try self.context.fetch(fetchRequestMil)
                            self.results.sort { $0.date! > $1.date! }
                            self.personnelArray = try self.context.fetch(fetchRequestPers)
                            self.personnelArray.sort { $0.date! > $1.date! }
                            print("Data fetched and saved successfully.")
                            
                           
                            for militaryLoss in self.results {
                                if let personnelLoss = personnelArray.first(where: { Calendar.current.isDate($0.date!, inSameDayAs: militaryLoss.date!) }) {
                                    groupedData[militaryLoss.date!] = (militaryLoss, personnelLoss)
                                }
                            }
                            
                          
                            
                        } catch {
                            print("Error fetching data: \(error)")
                        }
                    }
                    
                    completion() // Call the completion handler once both methods are done
                }
            }
        }
    }

}




