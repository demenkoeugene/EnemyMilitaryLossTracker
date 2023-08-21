//
//  APIManager.swift
//  MacPawBootcamp
//
//  Created by Eugene Demenko on 21.08.2023.
//

import Foundation
import CoreData

//https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/c5f7deaa838c0a2243b5a59d5b5fd9cf463b4dda/data/russia_losses_personnel.json -  contains Personnel Losses during the war
//https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment_oryx.json - contains more granular data of Equipment Losses during the war based on Oryx
//https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment.json - contains Equipment Losses during the war
//https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment_correction.json  - contains some data correction in Equipment Losses Dataset (date: 2022-10-13, date: 2023-05-27)

class APIManager{
    static let shared = APIManager()
    
    let personnelLossesURL = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/c5f7deaa838c0a2243b5a59d5b5fd9cf463b4dda/data/russia_losses_personnel.json"
   
   
    func getPersonnelLosses(viewContext: NSManagedObjectContext){
        guard let url = URL(string: personnelLossesURL) else{
            print("Invalid server URL")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ data,response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
                
            }
            
    

            do {
                let personnelLosses: [PersonnelLossesModel] = try JSONDecoder().decode([PersonnelLossesModel].self, from: data)
                print("Decoded personnel losses count:", personnelLosses.count)
               
                
                for personnelLossesItem in personnelLosses {
                    let perslosses = PersonnelLosses(context: viewContext)
                    perslosses.date = personnelLossesItem.date
                    perslosses.day = Int64(personnelLossesItem.day)
                    perslosses.personnel = Int32(personnelLossesItem.personnel)
                    perslosses.personnelInfo = personnelLossesItem.personnelInfo
                    perslosses.pow = Int32(personnelLossesItem.pow ?? 0) 
                }
                try? viewContext.save()
                
            } catch {
                print("Decoding error:", error)
            }
            let finalCount = try? viewContext.count(for: PersonnelLosses.fetchRequest())

           
            print("Final Count:", finalCount ?? "N/A")
           
        }.resume()
        
    }
   

    
    let equipmentLossesOryxURL = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment_oryx.json"
    let equipmentLossesURL = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/c5f7deaa838c0a2243b5a59d5b5fd9cf463b4dda/data/russia_losses_equipment.json"
    let equipmentLossesURLCorrection = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/5fc26df03f91acfe175bc856dbd4fd9e5b77ab09/data/russia_losses_equipment_correction.json"
    
    
    func getEquipmentLossesOryx(){
        guard let url = URL(string: equipmentLossesOryxURL) else{
            print("Invalid server URL")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ data,response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
                
            }
            do {
                let equipmentLossesOryx: [EquipmentLossesOryxModel] = try JSONDecoder().decode([EquipmentLossesOryxModel].self, from: data)
                print(equipmentLossesOryx.count)
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
        
    }
    
    func getEquipmentLossesURL(){
        guard let url = URL(string: equipmentLossesURL) else{
            print("Invalid server URL")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ data,response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
                
            }
            do {
                let militaryLosses: [MilitaryLossesModel] = try JSONDecoder().decode([MilitaryLossesModel].self, from: data)
                print(militaryLosses.count)
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
        
    }
    
    func getEquipmentLossesCorrection(){
        guard let url = URL(string: equipmentLossesURLCorrection) else{
            print("Invalid server URL")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ data,response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else {
                print("No data received")
                return
                
            }
            do {
                let militaryLosses: [MilitaryLossesModel] = try JSONDecoder().decode([MilitaryLossesModel].self, from: data)
                print(militaryLosses.count)
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}

