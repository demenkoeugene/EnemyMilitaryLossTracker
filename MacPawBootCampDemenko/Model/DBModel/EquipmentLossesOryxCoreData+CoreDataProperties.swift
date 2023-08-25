//
//  EquipmentLossesOryxCoreData+CoreDataProperties.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 25.08.2023.
//
//

import Foundation
import CoreData


extension EquipmentLossesOryxCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EquipmentLossesOryxCoreData> {
        return NSFetchRequest<EquipmentLossesOryxCoreData>(entityName: "EquipmentLossesOryxCoreData")
    }

    @NSManaged public var equipmentOryx: String?
    @NSManaged public var equipmentUA: String?
    @NSManaged public var lossesTotal: Int32
    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?

}

extension EquipmentLossesOryxCoreData : Identifiable {

}
