//
//  CoreDataManager.swift
//  Inception
//
//  Created by Jineeee on 2022/07/20.
//

import UIKit
import CoreData

class SleepTrackDataManager {
  static let shared: SleepTrackDataManager = SleepTrackDataManager()
  
  let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
  lazy var context = appDelegate?.persistentContainer.viewContext
  let modelName: String = "SleepRecordItem"
  
  var sleepRecords: [SleepRecordItem] = [SleepRecordItem]()
  
  func fetchSleepRecord() -> [SleepRecordItem] {

    if let context = context {
      let sortItem: NSSortDescriptor = NSSortDescriptor(key: "wakeupTime", ascending: false)
      let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
      fetchRequest.sortDescriptors = [sortItem]
      
      do {
        if let fetchResult: [SleepRecordItem] = try context.fetch(fetchRequest) as? [SleepRecordItem] {
          sleepRecords = fetchResult
        }
      } catch let error as NSError {
        print("Fetch 실패..: \(error), \(error.userInfo)")
      }
    }
    return sleepRecords
  }
  
  func createSleepRecord(trackedDate: String, bedTime: String, wakeupTime: Date, actualSleepHour: String, sleepSatisfaction: SleepSatisfacation.RawValue, onSuccess: @escaping ((Bool) -> Void)) {
    
    if let context = context,
       let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
      if let item: SleepRecordItem = NSManagedObject(entity: entity, insertInto: context) as? SleepRecordItem {
        item.trackedDate = trackedDate
        item.bedTime = bedTime
        item.wakeupTime = wakeupTime
        item.actualSleepHour = actualSleepHour
        item.sleepSatisfaction = sleepSatisfaction
        
        contextSave { success in
          onSuccess(success)
        }
      }
    }
  }
  
  func updateFirstItemSleepSatisfaction(sleepSatisfaction: SleepSatisfacation,onSuccess: @escaping ((Bool) -> Void)) {
    let firstItem = sleepRecords.first!
    firstItem.sleepSatisfaction = sleepSatisfaction.rawValue
    contextSave { success in
      onSuccess(success)
    }
  }
  
  func getFirstItemId() -> UUID? {
    return sleepRecords.first?.id ?? nil
  }

  func deleteSleepRecord(_ sleepRecord: SleepRecordItem, onSuccess: @escaping ((Bool) -> Void)) {
    context?.delete(sleepRecord)
    contextSave { success in
      onSuccess(success)
    }
  }
  
  func deleteAllSleepRecord() {
    let allItems = fetchSleepRecord()
    for item in allItems {
      context?.delete(item)
    }
  }
}

extension SleepTrackDataManager {
  
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}

