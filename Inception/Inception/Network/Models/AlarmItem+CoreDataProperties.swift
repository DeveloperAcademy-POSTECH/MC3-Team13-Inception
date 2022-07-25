//
//  AlarmItem+CoreDataProperties.swift
//  Inception
//
//  Created by Jineeee on 2022/07/21.
//
//

import Foundation
import CoreData


extension AlarmItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlarmItem> {
        return NSFetchRequest<AlarmItem>(entityName: "AlarmItem")
    }

    @NSManaged public var isOn: Bool
    @NSManaged public var bedTime: Date?
    @NSManaged public var wakeupTime: Date?

}

extension AlarmItem : Identifiable {

}
