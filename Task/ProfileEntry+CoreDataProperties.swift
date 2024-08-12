//
//  ProfileEntry+CoreDataProperties.swift
//  
//
//  Created by Sahitya on 11/08/24.
//
//

import Foundation
import CoreData


extension ProfileEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileEntry> {
        return NSFetchRequest<ProfileEntry>(entityName: "ProfileEntry")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var age: String?
    @NSManaged public var location: String?
    @NSManaged public var imageName: String?
    @NSManaged public var status: String?

}
