//
//  CoreDataManager.swift
//  Inception
//
//  Created by Jineeee on 2022/07/20.
//

import UIKit
import CoreData

class CoreDataManager {
  static let shared: CoreDataManager = CoreDataManager()
  
  let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
  lazy var context = appDelegate?.persistentContainer.viewContext
  
  let modelName: String = "SleepRecordItem"
  
  func getItems() -> [SleepRecordItem] {
    var models: [SleepRecordItem] = [SleepRecordItem]()
    
    if let context = context {
      let sortItem: NSSortDescriptor = NSSortDescriptor(key: "TrackedDate", ascending: true)
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
  
  func saveItem(trackedDate: String, bedTime: String, wakeupTime: String, actualSleepHour: String, sleepSatisfaction: SleepSatisfacation, onSuccess: @escaping ((Bool) -> Void)) {
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
}


extension CoreDataManager {
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

