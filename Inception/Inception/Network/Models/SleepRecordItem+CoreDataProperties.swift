//
//  SleepRecordItem+CoreDataProperties.swift
//  Inception
//
//  Created by Jineeee on 2022/08/01.
//
//

import Foundation
import CoreData


extension SleepRecordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SleepRecordItem> {
        return NSFetchRequest<SleepRecordItem>(entityName: "SleepRecordItem")
    }

    @NSManaged public var actualSleepHour: Int16
    @NSManaged public var bedTime: String?
    @NSManaged public var id: UUID?
    @NSManaged public var sleepSatisfaction: String?
    @NSManaged public var trackedDate: String?
    @NSManaged public var wakeupTime: Date?

}

extension SleepRecordItem : Identifiable {

}
