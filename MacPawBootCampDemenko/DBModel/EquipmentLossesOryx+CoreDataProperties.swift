//
//  EquipmentLossesOryx+CoreDataProperties.swift
//  MacPawBootcamp
//
//  Created by Eugene Demenko on 21.08.2023.
//
//

import Foundation
import CoreData


extension EquipmentLossesOryx {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EquipmentLossesOryx> {
        return NSFetchRequest<EquipmentLossesOryx>(entityName: "EquipmentLossesOryx")
    }

    @NSManaged public var equipmentOryx: String?
    @NSManaged public var model: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var lossesTotal: Int32
    @NSManaged public var equipmentUA: String?

}

extension EquipmentLossesOryx : Identifiable {

}
