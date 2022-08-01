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
  
  func fetchSleepRecord() -> [SleepRecordItem] {
    var models: [SleepRecordItem] = [SleepRecordItem]()
    
    if let context = context {
      // 최근 날짜 순으로 sorting
      let sortItem: NSSortDescriptor = NSSortDescriptor(key: "trackedDate", ascending: false)
      let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
      fetchRequest.sortDescriptors = [sortItem]
      
      do {
        if let fetchResult: [SleepRecordItem] = try context.fetch(fetchRequest) as? [SleepRecordItem] {
          models = fetchResult
        }
      } catch let error as NSError {
        print("Fetch 실패..: \(error), \(error.userInfo)")
      }
    }
    return models
  }
  
  func createSleepRecord(trackedDate: String, bedTime: String, wakeupTime: String, actualSleepHour: String, sleepSatisfaction: SleepSatisfacation.RawValue, onSuccess: @escaping ((Bool) -> Void)) {
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
  
  func updateSleepRecord(_ sleepRecord: SleepRecordItem, _ newSleepRecord: SleepRecordItem, onSuccess: @escaping ((Bool) -> Void)) {
    let allItems = fetchSleepRecord()
    for item in allItems {
      if item.id == sleepRecord.id {
        item.bedTime = newSleepRecord.bedTime
        item.wakeupTime = newSleepRecord.wakeupTime
        item.sleepSatisfaction = newSleepRecord.sleepSatisfaction
      }
    }
    contextSave { success in
      onSuccess(success)
    }
  }
  
  func deleteSleepRecord(_ sleepRecord: SleepRecordItem) {
    context?.delete(sleepRecord)
  }
  
  func deleteAllSleepRecord() {
    let allItems = fetchSleepRecord()
    for item in allItems {
      context?.delete(item)
    }
  }
}

extension SleepTrackDataManager {
    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
        return fetchRequest
    }
    
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

