//
//  PalmListItem+CoreDataProperties.swift
//  PalmList
//
//  Created by Timothy Waters on 1/22/19.
//  Copyright © 2019 Timmy Waters Software. All rights reserved.
//
//

import Foundation
import CoreData


extension PalmListItem {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PalmListItem> {
        return NSFetchRequest<PalmListItem>(entityName: "PalmListItem")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var itemText: String
    @NSManaged public var priority: String

}
