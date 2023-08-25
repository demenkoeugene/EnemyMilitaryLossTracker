//
//  EquipmentLosses.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 22.08.2023.
//

import UIKit
import CoreData

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
    
    private struct Labels {
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
    
    private lazy var labels = Labels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        fetchDataAndSetupViews()
    }
    
    
    private func configureUI() {
        createDatePicker()
        setupLabelConstraints()
        view.addSubview(dataLabel)
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    
    private func fetchDataAndSetupViews() {
        fetchData {
            let currentDate = self.results.first?.date ?? Date()
            print("current date \(currentDate)")
            self.fetchMilitaryLosses(for: currentDate)
            self.datePicker.date = currentDate
        }
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
    
    
    func createDatePicker() {
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
        
        guard let (currentMilitaryLoss, currentPersonnelLoss) = groupedData[date],
              let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: date),
              let (previousMilitaryLoss, previousPersonnelLoss) = groupedData[previousDate] else {
            clearLabels()
            dataLabel.text = "No data available for the selected date."
            return
        }
        
        labels.dayLabel.text = "Day: \(currentMilitaryLoss.day)"
        
        let labelData: [(UILabel, String, Int32, Int32)] = [
            (labels.personellLabel, "Personell", currentPersonnelLoss.personnel, previousPersonnelLoss.personnel),
            (labels.aircraftLabel, "Aircraft", currentMilitaryLoss.aircraft, previousMilitaryLoss.aircraft),
            (labels.helicopterLabel, "Helicopter", currentMilitaryLoss.helicopter, previousMilitaryLoss.helicopter),
            (labels.tankLabel, "Tank", currentMilitaryLoss.tank, previousMilitaryLoss.tank),
            (labels.APCLabel, "APC", currentMilitaryLoss.apc, previousMilitaryLoss.apc),
            (labels.fieldArtilleryLabel, "Field Artillery", currentMilitaryLoss.fieldArtillery, previousMilitaryLoss.fieldArtillery),
            (labels.MRLLabel, "MRL", currentMilitaryLoss.mrl, previousMilitaryLoss.mrl),
            (labels.droneLabel, "Drone", currentMilitaryLoss.drone, previousMilitaryLoss.drone),
            (labels.navalShipLabel, "Naval Ship", currentMilitaryLoss.navalShip, previousMilitaryLoss.navalShip),
            (labels.antiAircraftWarfareLabel, "Anti-Aircraft Warfare", currentMilitaryLoss.antiAircraftWarfare, previousMilitaryLoss.antiAircraftWarfare)
        ]
        
        for (label, key, current, previous) in labelData {
            updateLabel(label, with: key, current: current, previous: previous)
        }
        
        if currentMilitaryLoss.militaryAuto != 0 {
            updateLabel(labels.militaryAutoLabel,
                        with: "Military Auto",
                        current: currentMilitaryLoss.militaryAuto,
                        previous: previousMilitaryLoss.militaryAuto)
        } else {
            labels.militaryAutoLabel.text = ""
        }
        
        dataLabel.text = ""
    }

    
    private func updateLabel(_ label: UILabel, with key: String, current: Int32, previous: Int32) {
        let change = Int(current) - Int(previous)
        let changeString = change != 0 ? "(\(change > 0 ? "+" : "")\(change))" : ""
        label.text = "\(key): \(current) \(changeString)"
    }
    
    private func clearLabels() {
        let allLabels = [
            labels.dayLabel,
            labels.personellLabel,
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
        
        allLabels.forEach { $0.text = "" }
    }
}

extension LossesController {
    private func fetchData(completion: @escaping () -> Void) {
        APIManager.shared.getEquipmentLosses(viewContext: context) { [weak self] error in
            if let error = error {
                self?.handleError("equipment", error)
            } else {
                self?.fetchPersonnelLosses(completion: completion)
            }
        }
    }
    
    private func fetchPersonnelLosses(completion: @escaping () -> Void) {
        APIManager.shared.getPersonnelLosses(viewContext: context) { [weak self] error in
            if let error = error {
                self?.handleError("personnel", error)
            } else {
                self?.fetchAndSortData(completion: completion)
            }
        }
    }
    
    private func fetchAndSortData(completion: @escaping () -> Void) {
        let fetchRequestMil: NSFetchRequest<MilitaryLossesCoreData> = MilitaryLossesCoreData.fetchRequest()
        let fetchRequestPers: NSFetchRequest<PersonelLossesCoreData> = PersonelLossesCoreData.fetchRequest()
        
        do {
            self.results = try context.fetch(fetchRequestMil)
            self.results.sort { $0.date! > $1.date! }
            self.personnelArray = try context.fetch(fetchRequestPers)
            self.personnelArray.sort { $0.date! > $1.date! }
            
            groupData()
            
            print("Data fetched and saved successfully.")
        } catch {
            print("Error fetching data: \(error)")
        }
        
        completion() // Call the completion handler once data fetching and sorting are done
    }
    
    private func handleError(_ type: String, _ error: Error) {
        print("Error fetching and saving \(type) losses:", error)
    }
    
    private func groupData() {
        for militaryLoss in results {
            if let personnelLoss = personnelArray.first(where: { Calendar.current.isDate($0.date!, inSameDayAs: militaryLoss.date!) }) {
                groupedData[militaryLoss.date!] = (militaryLoss, personnelLoss)
            }
        }
    }
}



