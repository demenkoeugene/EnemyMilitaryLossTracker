//
//  PersonelLossesCoreData+CoreDataProperties.swift
//  MacPawBootCampDemenko
//
//  Created by Eugene Demenko on 25.08.2023.
//
//

import Foundation
import CoreData


extension PersonelLossesCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonelLossesCoreData> {
        return NSFetchRequest<PersonelLossesCoreData>(entityName: "PersonelLossesCoreData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var day: Int64
    @NSManaged public var personnel: Int32
    @NSManaged public var personnelInfo: String?
    @NSManaged public var pow: Int32

}

extension PersonelLossesCoreData : Identifiable {

}
