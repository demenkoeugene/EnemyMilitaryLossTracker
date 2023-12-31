//
//  ModelParsingJSON.swift
//  MacPawBootcamp
//
//  Created by Eugene Demenko on 21.08.2023.
//


import Foundation

struct PersonnelLossesModel: Decodable {
    let date: String
    let day: Int
    let personnel: Int
    let personnelInfo: String
    let pow: Int?  //Prisoner of War (POW) - has not been tracked since 2022-04-28
    
    private enum CodingKeys: String, CodingKey {
        case date, day, personnel,pow
        case personnelInfo = "personnel*"
    }
}


struct MilitaryLossesModel: Decodable {
    let date: String
    let day: Int
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let APC: Int //Armored Personnel Carrier (APC)
    let fieldArtillery: Int
    let MRL: Int //Multiple Rocket Launcher (MRL)
    let militaryAuto: Int?
    let fuelTank: Int?
    let drone: Int
    let navalShip: Int
    let antiAircraftWarfare: Int
    
    private enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank, APC
        case fieldArtillery = "field artillery"
        case MRL, militaryAuto = "military auto", fuelTank, drone
        case navalShip = "naval ship", antiAircraftWarfare = "anti-aircraft warfare"
    }
}


struct DonationModel: Decodable{
    let name: String
    let organisationURL: String
}



