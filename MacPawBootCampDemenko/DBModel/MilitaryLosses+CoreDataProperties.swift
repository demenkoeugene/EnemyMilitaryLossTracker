//
//  MilitaryLosses+CoreDataProperties.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//
//

import Foundation
import CoreData


extension MilitaryLosses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MilitaryLosses> {
        return NSFetchRequest<MilitaryLosses>(entityName: "MilitaryLosses")
    }

    @NSManaged public var aircraft: Int32
    @NSManaged public var antiAircraftWarfare: Int32
    @NSManaged public var apc: Int32
    @NSManaged public var date: String?
    @NSManaged public var day: Int32
    @NSManaged public var drone: Int32
    @NSManaged public var fieldArtillery: Int32
    @NSManaged public var fuelTank: Int32
    @NSManaged public var helicopter: Int32
    @NSManaged public var militaryAuto: Int32
    @NSManaged public var mrl: Int32
    @NSManaged public var navalShip: Int32
    @NSManaged public var tank: Int32

}

extension MilitaryLosses : Identifiable {

}
