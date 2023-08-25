//
//  EquipmentOryxModel.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 24.08.2023.
//

import Foundation

struct EquipmentLossesOryxModel : Decodable{
    let equipmentOryx: String
    let model: String
    let manufacturer: String
    let lossesTotal: Int
    let equipmentUA: String //Unmanned Aerial
    
    private enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model
        case manufacturer
        case lossesTotal = "losses_total"
        case equipmentUA = "equipment_ua"
    }
}


struct Equipment {
    var filteredArrays: [(title: String, equipment: [EquipmentLossesOryxCoreData])] = []

    
    var antiAircraftGuns: [EquipmentLossesOryxCoreData] = []
    var jammersAndDeceptionSystems: [EquipmentLossesOryxCoreData] = []
    var commandPostsAndCommunicationsStations: [EquipmentLossesOryxCoreData] = []
    var multipleRocketLaunchers: [EquipmentLossesOryxCoreData] = []
    var surfaceToAirMissileSystems: [EquipmentLossesOryxCoreData] = []
    var trucksVehiclesAndJeeps: [EquipmentLossesOryxCoreData] = []
    var armouredFightingVehicles: [EquipmentLossesOryxCoreData] = []
    var selfPropelledAntiTankMissileSystems: [EquipmentLossesOryxCoreData] = []
    var mineResistantAmbushProtected: [EquipmentLossesOryxCoreData] = []
    var aircraft: [EquipmentLossesOryxCoreData] = []
    var selfPropelledAntiAircraftGuns: [EquipmentLossesOryxCoreData] = []
    var infantryMobilityVehicles: [EquipmentLossesOryxCoreData] = []
    var selfPropelledArtillery: [EquipmentLossesOryxCoreData] = []
    var towedArtillery: [EquipmentLossesOryxCoreData] = []
    var tanks: [EquipmentLossesOryxCoreData] = []
    var artillerySupportVehiclesAndEquipment: [EquipmentLossesOryxCoreData] = []
    var helicopters: [EquipmentLossesOryxCoreData] = []
    var navalShips: [EquipmentLossesOryxCoreData] = []
    var radars: [EquipmentLossesOryxCoreData] = []
    var reconnaissanceUnmannedAerialVehicles: [EquipmentLossesOryxCoreData] = []
    var infantryFightingVehicles: [EquipmentLossesOryxCoreData] = []
    var unmannedCombatAerialVehicles: [EquipmentLossesOryxCoreData] = []
    var engineeringVehiclesAndEquipment: [EquipmentLossesOryxCoreData] = []
    var armouredPersonnelCarriers: [EquipmentLossesOryxCoreData] = []
    
    init(equipment: [EquipmentLossesOryxCoreData]) {
        self.antiAircraftGuns = filterEquipment(equipment, categoryName: "Anti-Aircraft Guns")
        self.jammersAndDeceptionSystems = filterEquipment(equipment, categoryName: "Jammers And Deception Systems")
        self.commandPostsAndCommunicationsStations = filterEquipment(equipment, categoryName: "Command Posts And Communications Stations")
        self.multipleRocketLaunchers = filterEquipment(equipment, categoryName: "Multiple Rocket Launchers")
        self.surfaceToAirMissileSystems = filterEquipment(equipment, categoryName: "Surface-To-Air Missile Systems")
        self.trucksVehiclesAndJeeps = filterEquipment(equipment, categoryName: "Trucks, Vehicles and Jeeps")
        self.armouredFightingVehicles = filterEquipment(equipment, categoryName: "Armoured Fighting Vehicles")
        self.selfPropelledAntiTankMissileSystems = filterEquipment(equipment, categoryName: "Self-Propelled Anti-Tank Missile Systems")
        self.mineResistantAmbushProtected = filterEquipment(equipment, categoryName: "Mine-Resistant Ambush Protected")
        self.aircraft = filterEquipment(equipment, categoryName: "Aircraft")
        self.selfPropelledAntiAircraftGuns = filterEquipment(equipment, categoryName: "Self-Propelled Anti-Aircraft Guns")
        self.infantryMobilityVehicles = filterEquipment(equipment, categoryName: "Infantry Mobility Vehicles")
        self.selfPropelledArtillery = filterEquipment(equipment, categoryName: "Self-Propelled Artillery")
        self.towedArtillery = filterEquipment(equipment, categoryName: "Towed Artillery")
        self.tanks = filterEquipment(equipment, categoryName: "Tanks")
        self.artillerySupportVehiclesAndEquipment = filterEquipment(equipment, categoryName: "Artillery Support Vehicles And Equipment")
        self.helicopters = filterEquipment(equipment, categoryName: "Helicopters")
        self.navalShips = filterEquipment(equipment, categoryName: "Naval Ships")
        self.radars = filterEquipment(equipment, categoryName: "Radars")
        self.reconnaissanceUnmannedAerialVehicles = filterEquipment(equipment, categoryName: "Reconnaissance Unmanned Aerial Vehicles")
        self.infantryFightingVehicles = filterEquipment(equipment, categoryName: "Infantry Fighting Vehicles")
        self.unmannedCombatAerialVehicles = filterEquipment(equipment, categoryName: "Unmanned Combat Aerial Vehicles")
        self.engineeringVehiclesAndEquipment = filterEquipment(equipment, categoryName: "Engineering Vehicles And Equipment")
        self.armouredPersonnelCarriers = filterEquipment(equipment, categoryName: "Armoured Personnel Carriers")
    }
    init(){
    }
   
  
    
    private func filterEquipment(_ equipment: [EquipmentLossesOryxCoreData], categoryName: String) -> [EquipmentLossesOryxCoreData] {
           return equipment.filter { $0.equipmentOryx == categoryName }
       }
}

extension Equipment {
    var allArrays: [(title: String, equipment: [EquipmentLossesOryxCoreData])] {
        [
            ("Aircraft", aircraft),
            ("Anti-Aircraft Guns", antiAircraftGuns),
            ("Armoured Fighting Vehicles", armouredFightingVehicles),
            ("Armoured Personnel Carriers", armouredPersonnelCarriers),
            ("Artillery Support Vehicles And Equipment", artillerySupportVehiclesAndEquipment),
            ("Command Posts And Communications Stations", commandPostsAndCommunicationsStations),
            ("Engineering Vehicles And Equipment", engineeringVehiclesAndEquipment),
            ("Helicopters", helicopters),
            ("Infantry Fighting Vehicles", infantryFightingVehicles),
            ("Infantry Mobility Vehicles", infantryMobilityVehicles),
            ("Jammers And Deception Systems", jammersAndDeceptionSystems),
            ("Mine-Resistant Ambush Protected", mineResistantAmbushProtected),
            ("Multiple Rocket Launchers", multipleRocketLaunchers),
            ("Naval Ships", navalShips),
            ("Radars", radars),
            ("Reconnaissance Unmanned Aerial Vehicles", reconnaissanceUnmannedAerialVehicles),
            ("Self-Propelled Anti-Aircraft Guns", selfPropelledAntiAircraftGuns),
            ("Self-Propelled Anti-Tank Missile Systems", selfPropelledAntiTankMissileSystems),
            ("Self-Propelled Artillery", selfPropelledArtillery),
            ("Surface-To-Air Missile Systems", surfaceToAirMissileSystems),
            ("Tanks", tanks),
            ("Towed Artillery", towedArtillery),
            ("Trucks, Vehicles and Jeeps", trucksVehiclesAndJeeps),
            ("Unmanned Combat Aerial Vehicles", unmannedCombatAerialVehicles)
        ]
    }
    
   
   
}

