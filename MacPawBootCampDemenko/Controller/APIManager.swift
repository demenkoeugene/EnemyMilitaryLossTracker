//
//  APIManager.swift
//  MacPawBootcamp
//
//  Created by Eugene Demenko on 21.08.2023.
//

import Foundation
import CoreData

class APIManager {
    static let shared = APIManager()
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: - URLs
    private let personnelLossesURL = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/c5f7deaa838c0a2243b5a59d5b5fd9cf463b4dda/data/russia_losses_personnel.json"
    private let equipmentLossesURL = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/c5f7deaa838c0a2243b5a59d5b5fd9cf463b4dda/data/russia_losses_equipment.json"
    private let equipmentLossesOryxURL = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment_oryx.json"
    
    // MARK: - Getting personnel loss data from JSON
    func getPersonnelLosses(viewContext: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        // Clear existing data if needed
        PersistenceController.shared.clear()
        
        guard let url = URL(string: personnelLossesURL) else {
            print("Invalid server URL")
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error)
                completion(error)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let personnelLosses: [PersonnelLossesModel] = try JSONDecoder().decode([PersonnelLossesModel].self, from: data)
                print("Decoded personnel losses count:", personnelLosses.count)
                
                viewContext.perform {
                    for personnelLossesItem in personnelLosses {
                        let perslosses = PersonelLossesCoreData(context: viewContext)
                        // Create a date formatter to parse dates in "yyyy-MM-dd" format
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        
                        // Convert the formatted string to a Date object
                        if let formattedDate = dateFormatter.date(from: personnelLossesItem.date) {
                            perslosses.date = formattedDate
                        } else {
                            print("Failed to convert the actual date string to a Date.")
                        }
                        perslosses.day = Int64(personnelLossesItem.day)
                        perslosses.personnel = Int32(personnelLossesItem.personnel)
                        perslosses.personnelInfo = personnelLossesItem.personnelInfo
                        perslosses.pow = Int32(personnelLossesItem.pow ?? 0)
                    }
                    
                    do {
                        
                        try viewContext.save()
                        
                        
                        let finalCount = try? viewContext.count(for: PersonelLossesCoreData.fetchRequest())
                        print("Final Count:", finalCount ?? "N/A")
                        completion(nil)
                        
                    } catch {
                        print("Error saving context: \(error)")
                        completion(error)
                    }
                }
                
            } catch {
                print("Decoding error:", error)
                completion(error)
            }
        }.resume()
    }
    
    
    
    
    
    // MARK: - Getting equipment loss data from JSON
    func getEquipmentLosses(viewContext: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        // Clear existing data if needed
        PersistenceController.shared.clear()
        
        guard let url = URL(string: equipmentLossesURL) else {
            print("Invalid server URL")
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error)
                completion(error)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let militaryLosses: [MilitaryLossesModel] = try JSONDecoder().decode([MilitaryLossesModel].self, from: data)
                print("Decoded personnel losses count:", militaryLosses.count)
                
                viewContext.perform {
                    for militaryLossesItem in militaryLosses {
                        let millosses = MilitaryLossesCoreData(context: viewContext)
                        
                        // Create a date formatter to parse dates in "yyyy-MM-dd" format
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        
                        // Convert the formatted string to a Date object
                        if let formattedDate = dateFormatter.date(from: militaryLossesItem.date) {
                            millosses.date = formattedDate
                        } else {
                            print("Failed to convert the actual date string to a Date.")
                        }
                        
                        millosses.day = Int32(militaryLossesItem.day)
                        millosses.aircraft = Int32(militaryLossesItem.aircraft)
                        millosses.helicopter = Int32(militaryLossesItem.helicopter)
                        millosses.tank = Int32(militaryLossesItem.tank)
                        millosses.apc =  Int32(militaryLossesItem.APC)
                        millosses.fieldArtillery = Int32(militaryLossesItem.fieldArtillery)
                        millosses.mrl = Int32(militaryLossesItem.MRL)
                        millosses.militaryAuto = Int32(militaryLossesItem.militaryAuto ?? 0)
                        millosses.fuelTank = Int32(militaryLossesItem.fuelTank ?? 0)
                        millosses.drone = Int32(militaryLossesItem.drone)
                        millosses.navalShip = Int32(militaryLossesItem.navalShip)
                        millosses.antiAircraftWarfare = Int32(militaryLossesItem.antiAircraftWarfare)
                    }
                    
                    do {
                        
                        try viewContext.save()
                        
                        let finalCount = try? viewContext.count(for: MilitaryLossesCoreData.fetchRequest())
                        print("Final Count:", finalCount ?? "N/A")
                        completion(nil)
                        
                    } catch {
                        print("Error saving context: \(error)")
                        completion(error)
                    }
                }
                
            } catch {
                print("Decoding error:", error)
                completion(error)
            }
        }.resume()
    }
    
    
    
    func getEquipmentLossesOryx(viewContext: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        PersistenceController.shared.clear()
        
        guard let url = URL(string: equipmentLossesOryxURL) else {
            print("Invalid server URL")
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let oryxData: [EquipmentLossesOryxModel] = try JSONDecoder().decode([EquipmentLossesOryxModel].self, from: data)
                print("Decoded personnel losses count:", oryxData.count)
                
                self.saveOryxDataToContext(oryxData, in: viewContext, completion: completion)
                
            } catch {
                print("Decoding error:", error)
                completion(error)
            }
        }.resume()
    }

    private func saveOryxDataToContext(_ oryxData: [EquipmentLossesOryxModel], in context: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        context.perform {
            for oryxDataItem in oryxData {
                let oryxDataCore = EquipmentLossesOryxCoreData(context: context)
                oryxDataCore.equipmentOryx = oryxDataItem.equipmentOryx
                oryxDataCore.model = oryxDataItem.model
                oryxDataCore.manufacturer = oryxDataItem.manufacturer
                oryxDataCore.lossesTotal = Int32(oryxDataItem.lossesTotal)
                oryxDataCore.equipmentUA = oryxDataItem.equipmentUA
            }
            
            do {
                try context.save()
                print("Data saved to context successfully.")
                self.updateContextCount(in: context, completion: completion)
            } catch {
                print("Error saving context: \(error)")
                completion(error)
            }
        }
    }

    private func updateContextCount(in context: NSManagedObjectContext, completion: @escaping CompletionHandler) {
        do {
            let finalCount = try context.count(for: EquipmentLossesOryxCoreData.fetchRequest())
            print("Final Count:", finalCount)
            completion(nil)
        } catch {
            print("Error getting context count: \(error)")
            completion(error)
        }
    }

    
    
    func parseDonationJSON(completion: @escaping (Result<[DonationModel], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "donation", ofType: "json", inDirectory: "data") else {
            completion(.failure(NSError(domain: "Donation data not found", code: 404, userInfo: nil)))
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let donations = try decoder.decode([DonationModel].self, from: jsonData)
            completion(.success(donations))
        } catch {
            completion(.failure(error))
        }
    }
    
    
}

