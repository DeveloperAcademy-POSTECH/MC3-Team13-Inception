//
//  CoreDataManager.swift
//  Inception
//
//  Created by Jineeee on 2022/07/20.
//

import UIKit
import CoreData

class AlarmDataManger {
  static let shared: AlarmDataManger = AlarmDataManger()
  
  let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
  lazy var context = appDelegate?.persistentContainer.viewContext
  
  let modelName: String = "AlarmItem"
  
  func getItems() -> [SleepRecordItem] {
    var models: [SleepRecordItem] = [SleepRecordItem]()
    
    if let context = context {
      let sortItem: NSSortDescriptor = NSSortDescriptor(key: "bedTime", ascending: false)
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
  
  func saveItem(bedTime: Date, wakeupTime: Date, onSuccess: @escaping ((Bool) -> Void)) {
    if let context = context,
       let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
      if let item: AlarmItem = NSManagedObject(entity: entity, insertInto: context) as? AlarmItem {
        item.isOn = true
        item.bedTime = bedTime
        item.wakeupTime = wakeupTime
        
        contextSave { success in
          onSuccess(success)
        }
      }
    }
  }
  
  func deleteItem(_ sleepRecord: SleepRecordItem) {
    context?.delete(sleepRecord)
  }
  
  func deleteAllItem() {
    let allItems = getItems()
    for item in allItems {
      context?.delete(item)
    }
  }
}

extension AlarmDataManger {
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

