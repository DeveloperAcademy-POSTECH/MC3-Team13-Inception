//
//  SleepRecordItem+CoreDataProperties.swift
//  Inception
//
//  Created by Jineeee on 2022/07/20.
//
//

import Foundation
import CoreData


extension SleepRecordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SleepRecordItem> {
        return NSFetchRequest<SleepRecordItem>(entityName: "SleepRecordItem")
    }
  @NSManaged public var id : UUID
    @NSManaged public var trackedDate: String?
    @NSManaged public var bedTime: String?
    @NSManaged public var wakeupTime: Date?
    @NSManaged public var actualSleepHour: String?
    @NSManaged public var sleepSatisfaction: String?

}

extension SleepRecordItem : Identifiable {

}
