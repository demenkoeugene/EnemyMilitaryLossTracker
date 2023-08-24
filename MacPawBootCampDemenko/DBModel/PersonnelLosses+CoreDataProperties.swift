//
//  PersonnelLosses+CoreDataProperties.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 21.08.2023.
//
//

import Foundation
import CoreData


extension PersonnelLosses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonnelLosses> {
        return NSFetchRequest<PersonnelLosses>(entityName: "PersonnelLosses")
    }

    @NSManaged public var date: Date
    @NSManaged public var day: Int64
    @NSManaged public var personnel: Int32
    @NSManaged public var personnelInfo: String?
    @NSManaged public var pow: Int32

}

extension PersonnelLosses : Identifiable {

}
